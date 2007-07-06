# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/system-tools-backends/system-tools-backends-1.4.2-r1.ebuild,v 1.9 2007/02/11 09:52:18 vapier Exp $

inherit eutils gnome2

DESCRIPTION="Tools aimed to make easy the administration of UNIX systems"
HOMEPAGE="http://www.gnome.org/projects/gst/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="net-misc/openssh
	userland_GNU? ( sys-apps/shadow )
	>=dev-libs/libxml2-2.4.12
	!<app-admin/gnome-system-tools-1.1.91
	dev-lang/perl
	dev-perl/Net-DBus"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.29"

DOCS="AUTHORS BUGS ChangeLog HACKING NEWS README TODO"

src_compile() {
	gnome2_src_compile --with-stb-group=root
}

src_install() {
	gnome2_src_install
	
	# install init script
	newinitd "${FILESDIR}"/${PN} ${PN}
}

pkg_postinst() {
	einfo "If you want to get ${PN} to work properly"
	einfo "please add it to your default runlevel:"
	einfo "   # rc-update add ${PN} default"
}
