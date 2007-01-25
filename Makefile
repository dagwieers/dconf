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

install: docs
	-@[ ! -f $(DESTDIR)$(sysconfdir)/dconf.conf ] && install -D -m0644 config/dconf.conf $(DESTDIR)$(sysconfdir)/dconf.conf

	install -Dp -m0755 dconf $(DESTDIR)$(bindir)/dconf
	install -dp -m0755 $(DESTDIR)$(logdir)

	make install -C docs

	@echo "Also do: make install-<dist>   (with dist: debian|redhat|suse)"

install-redhat: install
	install -Dp -m0644 config/redhat.conf $(DESTDIR)$(sysconfdir)/dconf.d/redhat.conf

install-debian: install
	install -Dp -m0644 config/debian.conf $(DESTDIR)$(sysconfdir)/dconf.d/debian.conf

install-suse:
	install -Dp -m0644 config/suse.conf $(DESTDIR)$(sysconfdir)/dconf.d/suse.conf

docs:
	make -C docs all

dist: docs
	make -C docs dist
	find . ! -path '*/.svn*' | pax -d -w -x ustar -s ',^.,$(name)-$(version),' | bzip2 >../$(name)-$(version).tar.bz2

rpm: dist
	rpmbuild -tb --clean --rmsource --rmspec --define "_rpmfilename %%{NAME}-%%{VERSION}-%%{RELEASE}.%%{ARCH}.rpm" --define "_rpmdir ../" ../$(name)-$(version).tar.bz2

srpm: dist
	rpmbuild -ts --clean --rmsource --rmspec --define "_rpmfilename %%{NAME}-%%{VERSION}-%%{RELEASE}.%%{ARCH}.rpm" --define "_srcrpmdir ../" ../$(name)-$(version).tar.bz2
