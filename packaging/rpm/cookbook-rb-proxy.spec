Name: cookbook-rb-proxy
Version: %{__version}
Release: %{__release}%{?dist}
BuildArch: noarch
Summary: redborder proxy cookbook to install and configure the redborder environment

License: AGPL 3.0
URL: https://github.com/redBorder/cookbook-rb-proxy
Source0: %{name}-%{version}.tar.gz

%description
%{summary}

%prep
%setup -qn %{name}-%{version}

%build

%install
mkdir -p %{buildroot}/var/chef/cookbooks/rb-proxy
cp -f -r  resources/* %{buildroot}/var/chef/cookbooks/rb-proxy/
chmod -R 0755 %{buildroot}/var/chef/cookbooks/rb-proxy
install -D -m 0644 README.md %{buildroot}/var/chef/cookbooks/rb-proxy/README.md

%pre
if [ -d /var/chef/cookbooks/rb-proxy ]; then
    rm -rf /var/chef/cookbooks/rb-proxy
fi

%post
case "$1" in
  1)
    # This is an initial install.
    :
  ;;
  2)
    # This is an upgrade.
    su - -s /bin/bash -c 'source /etc/profile && rvm gemset use default && env knife cookbook upload rb-proxy'
  ;;
esac

%postun
# Deletes directory when uninstall the package
if [ "$1" = 0 ] && [ -d /var/chef/cookbooks/rb-proxy ]; then
  rm -rf /var/chef/cookbooks/rb-proxy
fi

%files
%defattr(0755,root,root)
/var/chef/cookbooks/rb-proxy
%defattr(0644,root,root)
/var/chef/cookbooks/rb-proxy/README.md

%doc

%changelog
* Thu Oct 10 2024 Miguel Negrón <manegron@redborder.com>
- Add pre and postun

* Thu Jan 18 2024 Miguel Negrón <manegron@redborder.com>
- Add journalctld configuration

* Thu Dec 14 2023 Miguel Álvarez <malvarez@redborder.com>
- Add cgroups

* Fri Dec 01 2023 David Vanhoucke <dvanhoucke@redborder.com>
- Add selinux

* Wed Feb 01 2023 Luis Blanco <ljblanco@redborder.com>
- Freeradius integration

* Tue Mar 22 2022 Miguel Negron <manegron@redborder.com>
- Initial release of proxy
