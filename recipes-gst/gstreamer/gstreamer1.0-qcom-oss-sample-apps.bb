inherit cmake pkgconfig

SUMMARY = "Generic ref sample apps for GStreamer pipelines."
SECTION = "multimedia"

LICENSE = "BSD-3-Clause-Clear"
LIC_FILES_CHKSUM = "file://${QCOM_COMMON_LICENSE_DIR}${LICENSE};md5=3771d4920bd6cdb8cbdf1e8344489ee0"

# Dependencies.
DEPENDS := "gstreamer1.0"
DEPENDS += "gstreamer1.0-plugins-base"
DEPENDS += "camera-server"

SRC_URI += "git://git.codelinaro.org/clo/le/platform/vendor/qcom-opensource/gst-plugins-qti-oss.git;protocol=https;rev=9282d88f010e69621ba1526d7cf6f5634173846d;branch=imsdk.lnx.2.0.0.r1-rel;subpath=gst-sample-apps"
S = "${WORKDIR}/gst-sample-apps"

# Install directries.
INSTALL_BINDIR := "${bindir}"
INSTALL_LIBDIR := "${libdir}"

# Camera-related variables
ENABLE_CAMERA          := "TRUE"
CAMERA_SERVICE         := "QMMF"
CAMERA_SERVICE:qcm6490 := "LECAM"

# Encode-related variables
ENABLE_VIDEO_ENCODE := "TRUE"

# Decode-related variables
ENABLE_VIDEO_DECODE := "TRUE"

# Display-related variables
ENABLE_DISPLAY := "TRUE"

# ML-related variables
ENABLE_ML := "TRUE"

# Camera-related variables
ENABLE_AUDIO := "TRUE"

EXTRA_OECMAKE += "-DGST_VERSION_REQUIRED=1.20.7"
EXTRA_OECMAKE += "-DSYSROOT_INCDIR=${STAGING_INCDIR}"
EXTRA_OECMAKE += "-DSYSROOT_LIBDIR=${STAGING_LIBDIR}"
EXTRA_OECMAKE += "-DGST_PLUGINS_QTI_OSS_INSTALL_BINDIR=${INSTALL_BINDIR}"
EXTRA_OECMAKE += "-DGST_PLUGINS_QTI_OSS_INSTALL_LIBDIR=${INSTALL_LIBDIR}"
EXTRA_OECMAKE += "-DENABLE_CAMERA=${ENABLE_CAMERA}"
EXTRA_OECMAKE += "-DENABLE_VIDEO_ENCODE=${ENABLE_VIDEO_ENCODE}"
EXTRA_OECMAKE += "-DENABLE_VIDEO_DECODE=${ENABLE_VIDEO_DECODE}"
EXTRA_OECMAKE += "-DENABLE_DISPLAY=${ENABLE_DISPLAY}"
EXTRA_OECMAKE += "-DENABLE_ML=${ENABLE_ML}"
EXTRA_OECMAKE += "-DENABLE_AUDIO=${ENABLE_AUDIO}"
EXTRA_OECMAKE += "-DCAMERA_SERVICE=${CAMERA_SERVICE}"

FILES:${PN} += "${INSTALL_BINDIR}"
FILES:${PN} += "${INSTALL_LIBDIR}"

SOLIBS = ".so*"
FILES_SOLIBSDEV = ""
