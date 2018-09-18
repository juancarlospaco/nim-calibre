# Nim-Calibre

[Calibre](https://calibre-ebook.com) eBooks App Database Client for [Nim](https://nim-lang.org).

![Books](https://source.unsplash.com/2FGHddOQcSQ/800x401 "Photo by https://unsplash.com/@michael_david_beckwith")


# Install

- `nimble install calibre`


# Use

```nim
import calibre

var client = Calibre(filepath: "/path/to/calibre/metadata.db")
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
```

- Run `nim doc calibre.nim` for more Docs.
- Feel free to send more proc with useful Queries.
- This is a read-only client, database is meant to be written by Calibre.
- If you have a Calibre database you can run the module as an Example `nim c -r calibre.nim`.


# Requisites

- None.


# Credits

- [**This code is ported from Python from Biblioteca-Guerrilla.**](https://github.com/elKaZe/biblioteca-guerrilla#biblioteca-guerrilla "eBook Web Catalog to embed on network Routers")
- All credit for the SQL Queries is for Biblioteca-Guerrilla.

See both if you want [calibre.py](https://github.com/elKaZe/biblioteca-guerrilla/blob/master/biblioteca_guerrilla/app/connector/calibre/calibre.py) &DoubleLongLeftRightArrow; [calibre.nim](https://github.com/juancarlospaco/nim-calibre/blob/master/src/calibre.nim)
