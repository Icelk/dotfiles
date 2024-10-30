// enable overscroll like on macOS. Makes flinging (on touchpad) feel nicer
user_pref("apz.overscroll.enabled", true);
// decrease friction after flinging - makes a fling travel longer on the page
user_pref("apz.fling_friction", "0.007");

// Enable the shorter tabbar.
user_pref("browser.compactmode.show", true);

// Hide some horrendous search engines
user_pref("browser.search.hiddenOneOffs", "Google,Amazon.se,Bing");

// Enable HTTPS-only mode
user_pref("dom.security.https_only_mode", true);
user_pref("dom.security.https_only_mode_ever_enabled", true);

// Enable WebGPU.
user_pref("dom.webgpu.enabled", true);

// Remove full screen warning
user_pref("full-screen-api.warning.timeout", 0);

// Make scroll wheel scrolling feel more snappy
user_pref("general.smoothScroll.msdPhysics.enabled", true);

// Enable some web platform features
user_pref("layout.css.backdrop-filter.enabled", true);

// Performance
user_pref("gfx.webrender.all", true);
user_pref("gfx.webrender.compositor", true);
user_pref("gfx.webrender.svg-images", true);
user_pref("layers.acceleration.force", true);

// it says it itself
user_pref("privacy.resistFingerprinting", false);
user_pref("privacy.resistFingerprinting.testGranularityMask", 4);
user_pref("privacy.spoof_english", 1);
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.trackingprotection.socialtracking.enabled", true);

// Fix emoji font (by default, it is "Twemoji Mozilla")
user_pref("font.name-list.emoji", "Noto Color Emoji");

// enable tab hover previews (very nice feature :))
user_pref("browser.tabs.hoverPreview.enabled", true);

// HW acceleration
user_pref("widget.dmabuf.force-enabled", true);
user_pref("gfx.x11-egl.force-enabled", true);
user_pref("media.ffmpeg.vaapi.enabled", true);
user_pref("media.av1.enabled", true);
user_pref("dom.media.webcodecs.h265.enabled", true)

// Disable the annoying middle button paste
user_pref("middlemouse.paste", false);
