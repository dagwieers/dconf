prefix = /usr
sysconfdir = /etc
bindir = $(prefix)/bin
sbindir = $(prefix)/sbin
libdir = $(prefix)/lib
datadir = $(prefix)/share
mandir = $(datadir)/man
localstatedir = /var

logdir = $(localstatedir)/log/dconf


all: install

install:
#	-[ ! -f $(DESTDIR)$(sysconfdir)/dconf.conf ] && install -D -m0644 dconf.conf $(DESTDIR)$(sysconfdir)/dconf.conf
	install -D -m0644 dconf-redhat.conf $(DESTDIR)$(sysconfdir)/dconf.conf
	-@[ ! -f $(DESTDIR)$(sysconfdir)/dconf-custom.conf ] && install -D -m0644 dconf-custom.conf $(DESTDIR)$(sysconfdir)/dconf-custom.conf
	install -D -m0755 dconf $(DESTDIR)$(bindir)/dconf

	install -d -m0755 $(DESTDIR)$(logdir)
	
tar:
