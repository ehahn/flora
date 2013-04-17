# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/skinlf/skinlf-6.7.ebuild,v 1.4 2012/12/30 16:53:57 ulm Exp $

EAPI="1"

JAVA_PKG_IUSE="examples source"
WANT_ANT_TASKS="ant-nodeps"
inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Skin Look and Feel - Skinning Engine for the Swing toolkit"
HOMEPAGE="http://${PN}.l2fprod.com/"
# Export from http://java.net/projects/skinlf/sources/svn/show/tags/SKINLF_6_2?rev=277
SRC_URI="http://ompldr.org/vaTRtbg/${P}.tar.bz2"

LICENSE="Apache-1.1"
SLOT="1"
KEYWORDS="~*"
IUSE=""

CDEPEND="dev-java/laf-plugin:0
	dev-java/xalan"
RDEPEND=">=virtual/jre-1.4
	${CDEPEND}"
DEPEND=">=virtual/jdk-1.4
	${CDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}/lib"

	java-pkg_jar-from xalan,laf-plugin
}

src_install() {
	java-pkg_dojar build/${PN}.jar
	# laf-plugin.jar is referenced in manifest's Class-Path
	# doesn't work without it due to class loader trickery
	# upstream solved this by absorbing laf-plugin in own jar...
	java-pkg_dojar lib/laf-plugin.jar

	use examples && java-pkg_doexamples src/examples
	use source && java-pkg_dosrc src/com src/*.java

	dodoc AUTHORS README THANKS || die
}
