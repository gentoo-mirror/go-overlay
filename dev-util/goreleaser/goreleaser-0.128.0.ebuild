# Copyright 1999-2020 Go Overlay Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

GOLANG_PKG_IMPORTPATH="github.com/${PN}"
GOLANG_PKG_ARCHIVEPREFIX="v"
GOLANG_PKG_LDFLAGS="-X main.version=${PV} -X main.commit=5efb690"

GOLANG_PKG_DEPENDENCIES=(
#	"github.com/alecthomas/kingpin:947dcec"   #v2.2.6
#	"github.com/alecthomas/template:a0175ee"
#	"github.com/alecthomas/units:2efee85"
#	"github.com/apex/log:ff0f669"
#	"github.com/blakesmith/ar:8bd4349"
#	"github.com/caarlos0/ctrlc:70dc48d"       #v1.0.0
#	"github.com/campoy/unique:88950e5"
#	"github.com/davecgh/go-spew:346938d"      #v1.1.0
#	"github.com/fatih/color:507f605"          #v1.6.0
#	"github.com/golang/protobuf:9255415"      #v1.0.0
#	"github.com/google/go-github:88eb4e9"
#	"github.com/google/go-querystring:53e6ce1"
#	"github.com/goreleaser/archive:342df38"   #v1.1.0
#	"github.com/goreleaser/nfpm:3c67919"      #v0.7.2
#	"github.com/masterminds/semver:8d82589"   #v1.4.1
#	"github.com/mattn/go-colorable:167de6b"   #v0.0.9
#	"github.com/mattn/go-isatty:0360b2a"      #v0.0.3
#	"github.com/mattn/go-zglob:4959821"
#	"github.com/mitchellh/go-homedir:b8bc1bf"
#	"github.com/pkg/errors:645ef00"           #v0.8.0
#	"github.com/pmezard/go-difflib:792786c"   #v1.0.0
#	"github.com/stretchr/testify:12b6f73"     #v1.2.1
#	"github.com/go-yaml/yaml:5420a8b -> gopkg.in/yaml.v2" #v2.2.1
#
#	"github.com/golang/oauth2:921ae39 -> golang.org/x"
#	"github.com/golang/sync:1d60e46 -> golang.org/x"
#	"github.com/golang/sys:3b87a42 -> golang.org/x"
#	"github.com/golang/net:61147c4 -> golang.org/x"
#
#	# Docs
#	"github.com/caarlos0/static:efbe357"
#	"github.com/PuerkitoBio/goquery:a86ea07"  #v1.4.0
#	"github.com/alecthomas/chroma:3020e2e"    #v0.4.0
#	"github.com/russross/blackfriday:55d61fa" #v1.5.1
#	"github.com/segmentio/go-snakecase:af59cb3"
#	"github.com/tj/front:739be21"
#	"github.com/tj/kingpin:7efc93b"           #v2.5.0
#	"github.com/andybalholm/cascadia:901648c" #v1.0.0
#	"github.com/danwakefield/fnmatch:cbb64ac"
#	"github.com/dlclark/regexp2:487489b"      #v1.1.6
#	"github.com/go-yaml/yaml:9f9df34 -> gopkg.in/yaml.v1"

	#code.gitea.io/sdk/gitea v0.0.0-20200128061546-ea2b5af37297
	"github.com/Masterminds/semver:910aa14" #v3.0.3
	"github.com/apex/log:295021f" #v1.1.1
	#github.com/aws/aws-sdk-go v1.25.11 // indirect
	#github.com/caarlos0/ctrlc v1.0.0
	"github.com/campoy/unique:88950e537e7e"
	#github.com/fatih/color v1.9.0
	#github.com/google/go-github/v28 v28.1.1
	#github.com/goreleaser/nfpm v1.1.10
	#github.com/imdario/mergo v0.3.8
	#github.com/jarcoal/httpmock v1.0.4
	#github.com/kamilsk/retry/v4 v4.7.2
	#github.com/mattn/go-zglob v0.0.1
	#github.com/mitchellh/go-homedir v1.1.0
	#github.com/pkg/errors v0.9.1
	#github.com/stretchr/testify v1.5.1
	#github.com/xanzy/go-gitlab v0.27.0
	#gocloud.dev v0.19.0
	"github.com/golang/net:6afb5195e5aa -> golang.org/x"
	"github.com/golang/oauth2:bf48bf16ab8d -> golang.org/x"
	"github.com/golang/sync:cd5d95a43a6e -> golang.org/x"
	#google.golang.org/appengine v1.6.5 // indirect
	#gopkg.in/alecthomas/kingpin.v2 v2.2.6
	#gopkg.in/yaml.v2 v2.2.8
)

inherit golang-single

DESCRIPTION="Deliver Go binaries as fast and easily as possible"
HOMEPAGE="https://goreleaser.com"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86 arm"
IUSE="doc"

src_compile() {
	GOLANG_PKG_LDFLAGS+=" -X main.date=$( date +%FT%T%z )"
	golang-single_src_compile

	if use doc; then
		einfo "Building static-docs ..."
		pushd "${GOPATH}"/src/github.com/caarlos0/static > /dev/null || die
			${EGO} install -ldflags '-s -w' -tags '' github.com/caarlos0/static/cmd/static-docs || die
		popd > /dev/null || die
	fi
}

src_install() {
	golang-single_src_install

	if use doc; then
		einfo "Creating documentation ..."

		mkdir "${T}"/docs || die
		"${GOBIN}"/static-docs \
			--syntax dracula \
			--in docs \
			--out "${T}"/docs \
			--title GoReleaser \
			--subtitle "Deliver Go binaries as fast and easily as possible" || die
		rm "${ED}"/usr/bin/static-docs || die

		docinto html
		dodoc -r "${T}"/docs/*
	fi
}
