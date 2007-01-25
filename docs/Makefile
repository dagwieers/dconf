prefix = /usr
datadir = $(prefix)/share
mandir = $(datadir)/man

all: dconf.1

install: dconf.1
	install -Dp -m0644 dconf.1 $(DESTDIR)$(mandir)/man1/dconf.1

dist: clean all

%.html: %.txt
	asciidoc -b xhtml11 -d manpage $<

%.1: %.1.xml
	xmlto man $<

%.xml: %.txt
	asciidoc -b docbook -d manpage $<

clean:
	rm -f dconf.1 dconf.1.html dconf.1.xml

