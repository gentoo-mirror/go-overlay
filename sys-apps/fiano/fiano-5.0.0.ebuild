# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GOLANG_PKG_IMPORTPATH="github.com/linuxboot"
GOLANG_PKG_BUILDPATH="/cmds/fmap /cmds/futk /cmds/glzma /cmds/utk"

inherit golang-single

KEYWORDS="amd64"

DESCRIPTION="Go-based tools for modifying UEFI firmware"
HOMEPAGE="https://github.com/linuxboot/fiano"

LICENSE="BSD"
SLOT="0"
IUSE=""
