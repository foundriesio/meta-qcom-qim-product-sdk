inherit systemd

DEPENDS:append:qcom = " libsoup-2.4"

FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI:append:qcom = " \
	file://gstd-env_qcm6490 \
	file://gstd.service \
	file://0001-Unblock-GSTD-pipeline-if-a-plugin-refuses-to-change-.patch \
"

SRCREV:qcom = "d924fcbc2123dcfcb35242ecf5dc2fc3049004b3"

SRC_URI:remove:qcom = "file://0001-gstd-yocto-compatibility.patch"

EXTRA_OECONF:append:qcom = " --with-gstd-runstatedir=/tmp"

do_configure:prepend:qcom () {
        echo -n "" > ${WORKDIR}/git/libgstc/python/Makefile.am
}

do_install:prepend:qcom () {
        install -d ${D}${localstatedir}/run/gstd
        install -d ${D}${localstatedir}/log/gstd
}

do_install:append:qcom () {
        install -d ${D}${sysconfdir}/default
        install -m 666 ${WORKDIR}/gstd-env_qcm6490 ${D}${sysconfdir}/default/gstd

        if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
          echo "d /run/${BPN} - - - -" > ${D}${sysconfdir}/tmpfiles.d/${BPN}.conf
          echo "d /${localstatedir}/log/${BPN} 0755 system video -" >> ${D}${sysconfdir}/tmpfiles.d/${BPN}.conf
        fi

        install -d ${D}${systemd_system_unitdir}
        install -m 644 ${WORKDIR}/gstd.service ${D}${systemd_system_unitdir}

        rm -rf ${D}${localstatedir}/run
}

SYSTEMD_SERVICE:${PN}:qcom = "gstd.service"

FILES:${PN}:append:qcom = " /tmp"

INSANE_SKIP:${PN}:append:qcom = " useless-rpaths empty-dirs"
