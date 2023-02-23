# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit savedconfig git-r3

DESCRIPTION="A suckless status monitor for window managers."
HOMEPAGE="https://tools.suckless.org/slstatus/"
EGIT_REPO_URI="https://git.suckless.org/slstatus/"

LICENSE="ISC"
SLOT="0"

RDEPEND="
	x11-libs/libX11
	x11-libs/libXft
"

DEPEND="
	${RDEPEND}
	x11-base/xorg-proto
"
BDEPEND="
	virtual/pkgconfig
"

src_prepare() {
	default

	# Replace default library paths with system library paths
	sed -i \
		-e "/^X11LIB/{s:/usr/X11R6/lib:/usr/$(get_libdir)/X11:}" \
		-e "/^X11INC/{s:/usr/X11R6/include:/usr/include/X11:}" \
		config.mk || die

	restore_config config.h
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}"/usr install
	dodoc README
	save_config config.h
}
