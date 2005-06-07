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

install:
#	-[ ! -f $(DESTDIR)$(sysconfdir)/dconf.conf ] && install -D -m0644 dconf.conf $(DESTDIR)$(sysconfdir)/dconf.conf
	install -Dp -m0644 config/dconf-redhat.conf $(DESTDIR)$(sysconfdir)/dconf.conf
	-@[ ! -f $(DESTDIR)$(sysconfdir)/dconf-custom.conf ] && install -D -m0644 config/dconf-custom.conf $(DESTDIR)$(sysconfdir)/dconf-custom.conf

	install -Dp -m0755 dconf $(DESTDIR)$(bindir)/dconf
	install -Dp -m0644 dconf.1 $(DESTDIR)$(mandir)/man1/dconf.1

	install -dp -m0755 $(DESTDIR)$(logdir)

tar:
