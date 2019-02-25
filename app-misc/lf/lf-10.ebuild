# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GOLANG_PKG_IMPORTPATH="github.com/gokcehan"
GOLANG_PKG_ARCHIVEPREFIX="r"
GOLANG_PKG_LDFLAGS="-s -w -X main.gVersion=${PV}"
GOLANG_PKG_VERSION="${GOLANG_PKG_ARCHIVEPREFIX}${PV}"
GOLANG_PKG_DEPENDENCIES=(
	"github.com/mattn/go-runewidth:703b5e6"
	"github.com/nsf/termbox-go:0298023"
)

inherit golang-single

DESCRIPTION="Terminal file manager written in Go, inspired by ranger."
HOMEPAGE="https://github.com/gokcehan/lf"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-lang/go
	dev-vcs/git[threads,gpg,curl]
"

src_install(){
	cd "${S}"
	go generate doc.go

	doman lf.1

	golang-single_src_install
}
