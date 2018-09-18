import db_sqlite

type Calibre* = object ## Calibre Client (Ported from Python).
 filepath*: string     ## Full path to Calibre database File *.db
 db*: DbConn           ## SQLite Gatabase Connection Instance.

func connect*(this: var Calibre) = this.db = open(this.filepath, nil, nil, nil)
func close*(this: Calibre) {.inline.} = this.db.close()  # Close the Gatabase.

proc get_all*(this: Calibre): seq[Row] =
  this.db.getAllRows(sql"""
  select id, title, pubdate, path
  from books
  order by title;""")

proc get_book_by_name*(this: Calibre, name: string): seq[Row] =
  this.db.getAllRows(sql"""
  select distinct b.id, b.title, b.pubdate, b.path
  from books b
  where b.title = ?
  order by b.title""", name)

proc get_by_author*(this: Calibre, author: string): seq[Row] =
  this.db.getAllRows(sql"""
  select distinct b.id, b.title, b.pubdate, b.path
  from books b, authors a
  where b.author_sort like "%"||a.sort||"%" and a.name like  ?
  order by b.title""", "%" & author & "%")

proc get_author_of_book*(this: Calibre, book_id: string): seq[Row] =
  this.db.getAllRows(sql"""
  select distinct a.name
  from authors a, books_authors_link bal
  where bal.author= a.id and bal.book = ?""", book_id)

proc get_tags_from_book*(this: Calibre, book_id: string): seq[Row] =
  this.db.getAllRows(sql"""
  select t.name
  from tags t,  books_tags_link btl
  where btl.tag = t.id and btl.book = ?
  order by t.name""", book_id)

proc get_synopsis*(this: Calibre, book_id: string): seq[Row] =
  this.db.getAllRows(sql"""
  select c.text
  from comments c
  where c.book = ?""", book_id)

proc get_authors*(this: Calibre): seq[Row] =
  this.db.getAllRows(sql"""
  select name
  from authors
  order by name""")

proc get_books_by_serie*(this: Calibre, serie: string): seq[Row] =
  this.db.getAllRows(sql"""
  select distinct b.id, b.title, b.pubdate, b.path
  from books b, series s, books_series_link bsl
  where bsl.book = b.id and bsl.series = s.id and s.name = ?
  order by b.title""", serie)

proc get_series*(this: Calibre): seq[Row] =
  this.db.getAllRows(sql"""
  select s.name
  from series s
  order by s.name""")

proc get_series_from_book*(this: Calibre, book_id: string): seq[Row] =
  this.db.getAllRows(sql"""
  select s.name
  from series s, books_series_link bsl
  where bsl.series = s.id and bsl.book = ?
  order by s.name""", book_id)

proc get_books_by_tag*(this: Calibre, tag: string): seq[Row] =
  this.db.getAllRows(sql"""
  select distinct b.id, b.title, b.pubdate, b.path
  from books b, tags t, books_tags_link btl
  where btl.book = b.id and btl.tag = t.id and t.name = ?
  order by b.title""", tag)

proc get_tags*(this: Calibre): seq[Row] =
  this.db.getAllRows(sql"""
  select name
  from tags
  order by name""")

proc get_formats*(this: Calibre, book_id: string): seq[Row] =
  this.db.getAllRows(sql"""
  select format, name
  from data
  where book=?""", book_id)

when is_main_module:
  var client = Calibre(filepath: "metadata.db")
  client.connect()
  echo client.get_all()
  echo client.get_tags()
  echo client.get_series()
  echo client.get_authors()
  echo client.get_formats("96")
  echo client.get_synopsis("96")
  echo client.get_author_of_book("96")
  echo client.get_book_by_name("Hellraiser")
  echo client.get_by_author("J. K. Rowling")
  client.close()
