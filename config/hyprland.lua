-- This is an example Hyprland config file.
--
-- Refer to the wiki for more information.

--
-- Please note not all available settings / options are set here.
-- For a full list, see the wiki
--

-- See https://wiki.hyprland.org/Configuring/Monitors/
hl.monitor({ output = "eDP-1", mode = "2256x1504@60", position = "0x0", scale = 1.33 })
-- monitor=eDP-1,2256x1504@60,0x0,1.175
hl.workspace_rule({ workspace = "1", monitor = "eDP-1" })
-- monitor=,preferred,auto,1
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })
-- monitor=desc:LG Electronics LG TV SSCR2 0x01010101,3840x2160@23.98,auto,2,bitdepth,10,cm,hdr,sdrbrightness,1.3
-- monitor=desc:LG Electronics LG TV SSCR2 0x01010101,3840x2160@25,auto,2
hl.monitor({ output = "desc:LG Electronics LG TV SSCR2 0x01010101", mode = "1920x1080@25", position = "auto", scale = 1 })
hl.monitor({ output = "desc:Samsung Electric Company LC49G95T HNTW801568", mode = "5120x1440@60", position = "-1712x-1440", scale = 1 })

hl.on("hyprland.start", function()
    hl.exec_cmd("hyprctl setcursor breeze_cursors 24")
end)

-- See https://wiki.hyprland.org/Configuring/Keywords/ for more

-- Execute your favorite apps at launch
-- exec-once = waybar & hyprpaper & firefox

-- Source a file (multi-file configs)
-- source = ~/.config/hypr/myColors.conf

-- For all categories, see https://wiki.hyprland.org/Configuring/Variables/
local inputVariant = "bracket-fn-ansi"
-- Override with switched variant
-- CORPL option ansi-switched
inputVariant = "ansi-switched-slash"
-- CORPL end

hl.config({ input = {
    kb_layout = "icelk",

    kb_variant = inputVariant,

    kb_model = "",
    kb_options = "",
    kb_rules = "",

    numlock_by_default = true,
    follow_mouse = 2,

    repeat_rate = 30,
    repeat_delay = 200,

    touchpad = {
        natural_scroll = true,
        scroll_factor = 0.3,
    },

    accel_profile = "adaptive",

    sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
} })

local keyboardVariant = "ansi-switched-slash"
-- Override with switched variant
-- CORPL option ansi-switched
keyboardVariant = "ansi"
-- CORPL end

hl.device({
    name = "semitek-usb-hid-gaming-keyboard",
    kb_variant = keyboardVariant,
})
local keyboardVariant2 = "ansi-switched-slash"
-- Override with switched variant
-- CORPL option ansi-switched
keyboardVariant2 = "ansi"
-- CORPL end

hl.device({
    name = "semitek-usb-hid-gaming-keyboard-2",
    kb_variant = keyboardVariant2,
})
hl.device({
    name = "logitech-gaming-mouse-g502",
    accel_profile = "flat",
    sensitivity = 0.3,
})

hl.config({ general = {
    -- See https://wiki.hyprland.org/Configuring/Variables/ for more

    gaps_in = 6,
    gaps_out = 10,
    -- CORPL section border_size =
    -- 2, -- light
    border_size = 0, -- dark
    -- CORPL end
    col = {
        active_border = "rgba(e8eff2bf)",
        inactive_border = "rgba(e8eff27f)",
    },

    layout = "dwindle",
} })

hl.config({ decoration = {
    -- See https://wiki.hyprland.org/Configuring/Variables/ for more

    -- CORPL section inactive_opacity =
    inactive_opacity = 0.9, -- dark
    -- 0.8, -- light
    -- CORPL end
    -- CORPL section active_opacity =
    active_opacity = 1.0, -- dark
    -- 0.95, -- light
    -- CORPL end

    rounding = 6,

    shadow = {
        enabled = false,
        range = 4,
        render_power = 3,
        color = "rgba(1a1a1aee)",
    },

    blur = {
        enabled = true,
        size = 8,
        passes = 2,
        new_optimizations = true,
        -- makes the opacity shine through, which gives some clarity to the blurred background
        ignore_opacity = true,
    },
} })

hl.config({ animations = { enabled = true } })

-- Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

hl.animation({ leaf = "windows", enabled = true, speed = 4, bezier = "default", style = "popin 90%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "layers", enabled = true, speed = 4, bezier = "default", style = "fade" })

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "swipe", action = "move", mods = "SUPER" })
hl.gesture({ fingers = 3, direction = "swipe", action = "resize", mods = "SUPER + SHIFT" })
hl.config({ gestures = {
    -- See https://wiki.hyprland.org/Configuring/Variables/ for more
    workspace_swipe_min_speed_to_force = 10,
    workspace_swipe_forever = true,
    workspace_swipe_use_r = true,
} })

hl.config({ misc = {
    mouse_move_enables_dpms = true,
    key_press_enables_dpms = true,
    middle_click_paste = false,
    render_unfocused_fps = 1,
    enable_anr_dialog = false,
} })
hl.config({ ecosystem = {
    no_update_news = true,
} })

hl.config({ render = {
    direct_scanout = true,
} })

hl.config({ xwayland = {
    force_zero_scaling = true,
} })

hl.config({ binds = {
    workspace_back_and_forth = true,
    allow_workspace_cycles = true,
} })

-- Example per-device config
-- See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
hl.device({
    name = "epic mouse V1",
    sensitivity = -0.5,
})

-- See https://wiki.hyprland.org/Configuring/Keywords/ for more
local mod = "SUPER"

-- Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
-- bind = $mod, Q, exec, kitty
-- bind = $mod, C, killactive,
-- bind = $mod, M, exit,
-- bind = $mod, E, exec, dolphin
-- bind = $mod, V, togglefloating,
-- bind = $mod, R, exec, wofi --show drun
-- bind = $mod, P, pseudo, # dwindle
-- bind = $mod, J, togglesplit, # dwindle

-- Icelk's bindings

hl.on("hyprland.start", function()
    -- Background
    hl.exec_cmd("cd ~/.dotfiles/config && watchexec -r --shell bash -f \"*hyprpaper.conf\" -- \"while :; do hyprpaper; sleep 1; done\"")
    -- Sleep screen
    hl.exec_cmd("cd ~/.dotfiles/config && watchexec -r --shell bash -f \"*hypridle.conf\" -- \"while :; do hypridle; sleep 1; done\"")
    -- enable powersave in hypridle
    hl.exec_cmd("corpl -k -e powersave ~/.config/hypr/hypridle.conf")
    -- start clipboard manager & bar
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    hl.exec_cmd("systemctl --user restart waybar")
    -- start auth agent
    hl.exec_cmd("systemctl --user start hyprpolkitagent.service")
    -- reset packages upgrade thing if it crashed or smth
    hl.exec_cmd("rm -f /tmp/run/packages-upgradable-count.pid")
end)

hl.bind(mod .. " + q", hl.dsp.window.close())
hl.bind(mod .. " + SHIFT + f", hl.dsp.window.fullscreen())
hl.bind(mod .. " + F11", hl.dsp.window.fullscreen())
hl.bind(mod .. " + SHIFT + space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + SHIFT + o", hl.dsp.window.set_prop({ prop = "opaque", value = "toggle" }))
hl.bind(mod .. " + SHIFT + i", function()
    local window = hl.get_active_window()
    if window then
        hl.dispatch(hl.dsp.window.fullscreen_state({ internal = window.fullscreen, client = 3, action = "set" }))
    end
end)

hl.bind(mod .. " + return", hl.dsp.exec_cmd("kitty -1"))
hl.bind(mod .. " + w", hl.dsp.exec_cmd("firefox"))
hl.bind(mod .. " + f", hl.dsp.exec_cmd("thunar"))
hl.bind(mod .. " + m", hl.dsp.exec_cmd("thunderbird"))
hl.bind(mod .. " + o", hl.dsp.exec_cmd("obsidian"))
hl.bind(mod .. " + b", hl.dsp.exec_cmd("blueman-manager"))
hl.bind(mod .. " + e", hl.dsp.exec_cmd("easyeffects"))

hl.bind(mod .. " + s", hl.dsp.exec_cmd("kitty -1 -e env PATH=$HOME/.cargo/bin:$PATH spotify_player"))
hl.bind(mod .. " + p", hl.dsp.exec_cmd("kitty -1 -e pulsemixer"))
hl.bind(mod .. " + t", hl.dsp.exec_cmd("kitty -1 -e btop"))

hl.bind(mod .. " + c", hl.dsp.exec_cmd("rofi -modi clipboard:~/.config/rofi/cliphist-rofi -show clipboard"))
hl.bind(mod .. " + SHIFT + c", hl.dsp.exec_cmd("rofi -modi clipboard:~/.config/rofi/cliphist-rofi-img -show clipboard -show-icons -theme img-clipboard"))
hl.bind(mod .. " + SHIFT + t", hl.dsp.exec_cmd("~/scripts/rofi/theme-change.fish"))
hl.bind(mod .. " + space", hl.dsp.exec_cmd("rofi -show drun -modi drun -theme clean -icon-theme \"kora\""))
hl.bind(mod .. " + pause", hl.dsp.exec_cmd("~/scripts/rofi/launch-powermenu.sh"))
hl.bind(mod .. " + SHIFT + p", hl.dsp.exec_cmd("~/scripts/rofi/launch-powermenu.sh"))

hl.bind("xf86audioplay", hl.dsp.exec_cmd("~/scripts/playerctl-custom.fish"))
hl.bind("xf86audiopause", hl.dsp.exec_cmd("~/scripts/playerctl-custom.fish"))
hl.bind("xf86audionext", hl.dsp.exec_cmd("~/scripts/playerctl-fast.sh next"))
hl.bind("xf86audioprev", hl.dsp.exec_cmd("~/scripts/playerctl-fast.sh previous"))
hl.bind(mod .. " + SHIFT + CTRL + k", hl.dsp.exec_cmd("~/scripts/playerctl-custom.fish"))
hl.bind(mod .. " + SHIFT + CTRL + j", hl.dsp.exec_cmd("~/scripts/playerctl-fast.sh previous"))
hl.bind(mod .. " + SHIFT + CTRL + l", hl.dsp.exec_cmd("~/scripts/playerctl-fast.sh next"))
hl.bind(mod .. " + SHIFT + period", hl.dsp.exec_cmd("~/scripts/audio-volume-change.sh + 5"), { repeating = true })
hl.bind(mod .. " + SHIFT + comma", hl.dsp.exec_cmd("~/scripts/audio-volume-change.sh - 5"), { repeating = true })
hl.bind("xf86audiomute", hl.dsp.exec_cmd("pulsemixer --toggle-mute"))
hl.bind("xf86audioraisevolume", hl.dsp.exec_cmd("~/scripts/audio-volume-change.sh + 5"), { repeating = true })
hl.bind("xf86audiolowervolume", hl.dsp.exec_cmd("~/scripts/audio-volume-change.sh - 5"), { repeating = true })
hl.bind(mod .. " + SHIFT + e", hl.dsp.exec_cmd("~/scripts/easyeffects-toggle.sh"))


hl.bind("xf86monbrightnessup", hl.dsp.exec_cmd("brightnessctl set +5%"), { repeating = true })
hl.bind("xf86monbrightnessdown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { repeating = true })


-- Move focus with $mod + VIM navigation
hl.bind(mod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + j", hl.dsp.focus({ direction = "down" }))
-- Move window with $mod + SHIFT + VIM navigation
hl.bind(mod .. " + SHIFT + h", hl.dsp.window.move({ direction = "left" }))
hl.bind(mod .. " + SHIFT + l", hl.dsp.window.move({ direction = "right" }))
hl.bind(mod .. " + SHIFT + k", hl.dsp.window.move({ direction = "up" }))
hl.bind(mod .. " + SHIFT + j", hl.dsp.window.move({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
for workspace = 1, 10 do
    hl.bind(mod .. " + " .. workspace % 10, hl.dsp.focus({ workspace = workspace }))
end

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for workspace = 1, 10 do
    hl.bind(mod .. " + SHIFT + " .. workspace % 10, hl.dsp.window.move({ workspace = workspace, follow = false }))
end

hl.bind(mod .. " + tab", hl.dsp.workspace.move({ monitor = "r" }))
hl.bind(mod .. " + SHIFT + tab", hl.dsp.workspace.move({ monitor = "l" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mod .. " + SHIFT + mouse:272", hl.dsp.window.resize(), { mouse = true })

hl.layer_rule({ name = "notifications-blur", match = { namespace = "notifications" }, blur = true })
hl.layer_rule({ name = "waybar-blur", match = { namespace = "waybar" }, blur = true })
hl.layer_rule({ name = "rofi-blur", match = { namespace = "rofi" }, blur = true })
hl.layer_rule({ name = "notifications-animation", match = { namespace = "notifications" }, animation = "slide" })
hl.layer_rule({ name = "waybar-animation", match = { namespace = "waybar" }, animation = "slide" })

hl.bind(mod .. " + escape", hl.dsp.exec_cmd("~/scripts/sleep.sh"), { release = true })
hl.bind(mod .. " + print", hl.dsp.exec_cmd("~/scripts/screenshot-whole.sh"))
hl.bind("print", hl.dsp.exec_cmd("~/scripts/screenshot.sh"))
hl.bind(mod .. " + SHIFT + q", hl.dsp.exec_cmd("dunstctl close"))
hl.bind(mod .. " + SHIFT + CTRL + q", hl.dsp.exit())
hl.bind("Pause", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mod .. " + r", hl.dsp.exec_cmd("~/scripts/service-management.sh"))
hl.bind(mod .. " + CTRL + 1", hl.dsp.exec_cmd("~/scripts/kb-toggle.sh"))
hl.bind(mod .. " + CTRL + 2", hl.dsp.exec_cmd("~/scripts/idle-toggle.sh"))

hl.window_rule({
    name = "xsnow-patch",
    match = { class = "xsnow" },
    float = true,
    no_blur = true,
    no_focus = true,
    no_shadow = true,
    border_size = 0,
    pin = true,
})

hl.config({ experimental = {
    --xx_color_management_v4 = true
    -- wide_color_gamut = true
    -- hdr = true
} })
