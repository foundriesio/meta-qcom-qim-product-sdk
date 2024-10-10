FILESEXTRAPATHS:prepend:qcom-custom-bsp := "${THISDIR}/gstreamer1.0-plugins-bad/1.20.4:"

SRC_URI:append:qcom-custom-bsp = "\
  file://0001-waylandsink-support-position-and-dimensions.patch \
  file://0002-waylandsink-support-scaler-protocol.patch \
  file://0003-waylandsink-support-gbm-buffer-backend-protocol.patch \
  file://0004-waylandsink-release-pending-buffers-in-composer.patch \
  file://0005-waylandsink-support-gap-buffers.patch \
  file://0005-videoparser-support-protected-content-caps.patch \
  file://0006-videoparser-update-width-and-height-on-resolution-ch.patch \
  file://0006-waylandsink-increase-timeout-limitation-in-gst_wl_wi.patch \
  file://0007-gstreamer1.0-plugins-bad-Add-meson-option-to-build-a.patch \
"

PACKAGECONFIG:append:qcom-custom-bsp = " webrtc sctp srt srtp"
DEPENDS:append:qcom:qcom-custom-bsp = " weston libnice libsrtp srt"

do_configure:prepend:qcom-custom-bsp() {
  install -d ${STAGING_DIR_HOST}${datadir}/wayland-protocols/stable/gbm-buffer-backend/
  cp ${STAGING_DIR_HOST}${datadir}/libweston-10/protocols/gbm-buffer-backend.xml ${STAGING_DIR_HOST}${datadir}/wayland-protocols/stable/gbm-buffer-backend
}
