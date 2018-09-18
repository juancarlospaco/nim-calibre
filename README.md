# Nim-Calibre

Calibre eBooks App Database Client for Nim.

![Books](https://source.unsplash.com/2FGHddOQcSQ/800x401 "Photo by https://unsplash.com/@michael_david_beckwith")


# Install

- `nimble install calibre`


# Use

```nim
import calibre

var client = Calibre(filepath: "/path/to/metadata.db")
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

- Run `nim doc hackpad.nim` for more Docs.
- Feel free to add more proc with useful Queries.
- This is a read-only client, database is meant to be written by Calibre.


# Requisites

- None.
