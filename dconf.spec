# $Id$
# Authority: dag
# Upstream: Dag Wieers <dag@wieers.com>

Summary: Collect system HW and SW configuration and manage changes
Name: dconf
Version: 0.3
Release: 1
License: GPL
Group: System Environment/Base
URL: http://dag.wieers.com/home-made/dconf/

Packager: Dag Wieers <dag@wieers.com>
Vendor: Dag Apt Repository, http://dag.wieers.com/apt/

Source: http://dag.wieers.com/home-made/dconf/dconf-%{version}.tar.bz2
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root

Requires: python

%description
Dconf is a tool to collect a system's hardware and software configuration.
It allows to take your system configuration with you or compare systems
(like nodes in a cluster) to troubleshoot HW or SW problems.

Dconf is also useful in projects where you have to manage changes as a
team. Dconf can send out changes to your systems to a list of email
addresses so that they can be revised.

%prep
%setup

%build

%install
%{__rm} -rf %{buildroot}
%makeinstall

%clean
%{__rm} -rf %{buildroot}

%files
%defattr(-, root, root, 0755)
%doc AUTHORS ChangeLog COPYING README THANKS TODO
%config(noreplace) %{_sysconfdir}/dconf.conf
%config(noreplace) %{_sysconfdir}/dconf-custom.conf
%{_bindir}/dconf

%changelog
* Sun Oct 24 2004 Dag Wieers <dag@wieers.com> - 0.3-1
- Updated to release 0.3.
