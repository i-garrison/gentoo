# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Move transition for OBS Studio"
HOMEPAGE="https://github.com/exeldro/obs-move-transition"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/exeldro/obs-move-transition.git"
else
	SRC_URI="https://github.com/exeldro/obs-move-transition/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64"
fi

LICENSE="GPL-2"
SLOT="0"

DEPEND="
	>=media-video/obs-studio-30.2.0
"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i '/-Werror$/d' cmake/ObsPluginHelpers.cmake || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DLIB_OUT_DIR=/lib64/obs-plugins
		-DLINUX_PORTABLE=OFF
	)

	cmake_src_configure
}
