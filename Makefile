name = dconf
version = $(shell awk '/^Version: / {print $$2}' $(name).spec)

prefix = /usr
sysconfdir = /etc
bindir = $(prefix)/bin
sbindir = $(prefix)/sbin
libdir = $(prefix)/lib
datadir = $(prefix)/share
mandir = $(datadir)/man
localstatedir = /var

logdir = $(localstatedir)/log/dconf


all:
	@echo "Nothing to be build."

install: dconf.1
	-@[ ! -f $(DESTDIR)$(sysconfdir)/dconf-custom.conf ] && install -D -m0644 config/dconf-custom.conf $(DESTDIR)$(sysconfdir)/dconf-custom.conf

	install -Dp -m0755 dconf $(DESTDIR)$(bindir)/dconf
	install -Dp -m0644 dconf.1 $(DESTDIR)$(mandir)/man1/dconf.1

	install -dp -m0755 $(DESTDIR)$(logdir)
	@echo "Also do: make install-<dist>   (with dist: debian|redhat|suse)"

install-redhat: install
	-[ ! -f $(DESTDIR)$(sysconfdir)/dconf.conf ] && install -Dp -m0644 config/dconf-redhat.conf $(DESTDIR)$(sysconfdir)/dconf.conf

install-debian: install
	-[ ! -f $(DESTDIR)$(sysconfdir)/dconf.conf ] && install -Dp -m0644 config/dconf-debian.conf $(DESTDIR)$(sysconfdir)/dconf.conf

install-suse:
	-[ ! -f $(DESTDIR)$(sysconfdir)/dconf.conf ] && install -Dp -m0644 config/dconf-suse.conf $(DESTDIR)$(sysconfdir)/dconf.conf

clean:
	rm -f dconf.1 dconf.1.html dconf.1.xml

%.html: %.txt
	asciidoc -b xhtml11 -d manpage $<

%.1: %.1.xml
	xmlto man $<

%.xml: %.txt
	asciidoc -b docbook -d manpage $<

dist: clean
	find . ! -wholename '*/.svn*' | pax -d -w -x ustar -s ,^,$(name)-$(version)/, | bzip2 >../$(name)-$(version).tar.bz2

rpm: dist
	rpmbuild -tb --clean --rmsource --rmspec --define "_rpmfilename %%{NAME}-%%{VERSION}-%%{RELEASE}.%%{ARCH}.rpm" --define "_rpmdir ../" ../$(name)-$(version).tar.bz2

srpm: dist
	rpmbuild -ts --clean --rmsource --rmspec --define "_rpmfilename %%{NAME}-%%{VERSION}-%%{RELEASE}.%%{ARCH}.rpm" --define "_srcrpmdir../" ../$(name)-$(version).tar.bz2
