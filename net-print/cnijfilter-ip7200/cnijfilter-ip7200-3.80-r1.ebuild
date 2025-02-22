# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

MY_P="cnijfilter-source-master"

DESCRIPTION="CUPS drivers for Canon Pixma inkjet printers (printer specific part)"
HOMEPAGE="https://wiki.gentoo.org/wiki/Canon_Pixma_Printer"
SRC_URI="https://github.com/mfld-fr/cnijfilter-source/archive/refs/heads/master.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+servicetools"

RDEPEND="
	>=net-print/cnijfilter-common-3.80[servicetools?]
	>=media-libs/libpng-1.5:0=
	>=media-libs/tiff-3.4:0=
	>=net-print/cups-1.6
	servicetools? (
		>=dev-libs/libxml2-2.7.3-r2
		>=x11-libs/gtk+-2.6:2
	)
"
DEPEND="${RDEPEND}
	sys-devel/gettext
"

S="${WORKDIR}/${MY_P}"

PRINTER_ID="406"
PRINTER_NAME="ip7200"

pkg_setup() {
	[[ -z ${LINGUAS} ]] && LINGUAS="en"

	if [[ ${MERGE_TYPE} != binary ]]; then
		# select components
		DIRS=(cnijfilter)
		# lgmon must be first as cngpijmon depends on it
		use servicetools && DIRS+=(lgmon cngpijmon maintenance)
	fi
}

src_prepare() {
	# missing macros directory make aclocal fail
	mkdir maintenance/m4 || die

	default

	local d
	for d in "${DIRS[@]}"; do
		pushd "${d}" > /dev/null || die
		eautoreconf
		popd > /dev/null || die
	done
}

src_configure() {
	local d
	for d in "${DIRS[@]}"; do
		pushd "${d}" > /dev/null || die
		econf \
			--enable-progpath="${EPREFIX}/usr/bin" \
			--program-suffix=${PRINTER_NAME}
		popd > /dev/null || die
	done
}

src_compile() {
	local d
	for d in "${DIRS[@]}"; do
		emake -C "${d}"
	done
}

src_install() {
	# install components specialized for the printer series

	local d
	for d in "${DIRS[@]}"; do
		emake -C "${d}" DESTDIR="${D}" install
	done

	# install specific files of the printer series

	local _libdir="/usr/$(get_libdir)"

	dolib.so ${PRINTER_ID}/libs_bin$(usex amd64 64 32)/*
	insinto "${_libdir}/cnijlib"
	doins ${PRINTER_ID}/database/*
	# create symlink from cnijlib to bjlib as some formats need it
	dosym cnijlib ${_libdir}/bjlib
	insinto "/usr/share/cups/model"
	doins ppd/canon${PRINTER_NAME}.ppd
}
