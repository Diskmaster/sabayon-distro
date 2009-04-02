# Copyright 2004-2007 Sabayon Linux
# Distributed under the terms of the GNU General Public License v2

inherit eutils

EGIT_TREE="${PV}"
EGIT_BRANCH="stable"
EGIT_REPO_URI="git://sabayon.org/projects/entropy.git"
inherit git

DESCRIPTION="Official Sabayon Linux Package Manager Server Interface (tagged release)"
HOMEPAGE="http://www.sabayonlinux.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
S="${WORKDIR}"/trunk

DEPEND="~sys-apps/entropy-${PV}"
RDEPEND="${DEPEND}"

src_install() {

	dodir /usr/$(get_libdir)/entropy/server

	# copy configuration
	cd ${S}/conf
	dodir /etc/entropy
	insinto /etc/entropy
	doins activator.conf
	doins reagent.conf
	doins server.conf.example

	packages="reagent.py activator.py"
	inspackages="reagent.py activator.py server_reagent.py server_activator.py entropy-system-daemon entropy-repository-daemon server_query.py"
	cd ${S}/server
	insinto /usr/$(get_libdir)/entropy/server
	for package in ${inspackages}; do
		doins ${package}
	done
	exeinto /usr/$(get_libdir)/entropy/server
	for package in ${packages}; do
		doexe ${package}
	done

	cd ${S}
	for package in ${packages}; do
		dosym /usr/$(get_libdir)/entropy/server/${package} /usr/sbin/${package/.py/}
	done

}
