# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GOLANG_PKG_IMPORTPATH="github.com/GoogleCloudPlatform"
GOLANG_PKG_BUILDPATH="/cmd/cloud_sql_proxy"
GOLANG_PKG_DEPENDENCIES=(
	"github.com/bazil/fuse:65cc252 -> bazil.org"
	"github.com/googleapis/google-cloud-go:fcb9a2d" # v0.37.4
	"github.com/golang/net:eb5bcb5 -> golang.org/x"
	"github.com/golang/oauth2:9f33145  -> golang.org/x"
	"github.com/golang/protobuf:b5d812f" # v1.3.1
	"github.com/golang/sys:b44545b -> golang.org/x"
	"github.com/golang/text:f21a4df  -> golang.org/x" # v0.3.0
	"github.com/google/go-genproto:64821d5"
	"github.com/googleapis/google-api-go-client:0cbcb99" # v0.3.2
	"github.com/hashicorp/golang-lru:7087cb7" # v0.5.1
	"github.com/census-instrumentation/opencensus-go:46618d0" # v0.20.0
	"github.com/grpc/grpc-go:236199d" # v1.20.0
)

inherit golang-single

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Cloud SQL proxy client and Go library"
HOMEPAGE="https://cloud.google.com/sql/docs/mysql/sql-proxy"

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

src_prepare() {
	golang-single_src_prepare

	golang_fix_importpath_alias \
		github.com/googleapis/google-cloud-go \
		cloud.google.com/go
	golang_fix_importpath_alias \
		github.com/googleapis/google-api-go-client \
		google.golang.org/api
	golang_fix_importpath_alias \
		github.com/grpc/grpc-go \
		google.golang.org/grpc
	golang_fix_importpath_alias \
		github.com/google/go-genproto \
		google.golang.org/genproto
	golang_fix_importpath_alias \
		github.com/census-instrumentation/opencensus-go \
		go.opencensus.io
}
