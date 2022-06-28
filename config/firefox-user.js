// enable overscroll like on macOS. Makes flinging (on touchpad) feel nicer
user_pref("apz.overscroll.enabled", true);
// decrease friction after flinging - makes a fling travel longer on the page
user_pref("apz.fling_friction", 0.05);

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

// Performance
user_pref("gfx.webrender.all", true);
user_pref("gfx.webrender.compositor", true);
user_pref("gfx.webrender.svg-images", true);
user_pref("layers.acceleration.force", true);

// it says it itself
user_pref("privacy.resistFingerprinting", true);
user_pref("privacy.resistFingerprinting.testGranularityMask", 4);
user_pref("privacy.spoof_english", 1);
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.trackingprotection.socialtracking.enabled", true);
