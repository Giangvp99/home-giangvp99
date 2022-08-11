local awful = require("awful")
local utils = require("utils")
-- run these commands on start up
local startup_scripts = {
    -- Other key remappings
    -- Remap modifier keys when pressed alone
    -- "xcape -e 'Control_L=Escape'",
    -- Faster key repeat response
    "xset r rate 200 30",
    -- Compositor
    "picom",
    -- Night mode
    -- "redshift-gtk",
    -- Set wallpaper
    "nitrogen --restore; sleep 1",
    -- Start ibus
    -- "ibus-daemon -drx",
    "nm-applet",
    --"blueman-applet",
    --"alacritty",
    --"gtk-launch safeeyes ; sleep 0.5 ; exit",
    "xmodmap $HOME/.config/xmodmap/.Xmodmap",
} -- Run all apps listed on start up
for _, app in ipairs(startup_scripts) do
    -- Don't spawn startup command if already exists
    awful.spawn.with_shell(
        string.format([[ pgrep -u $USER -x %s > /dev/null || (%s) ]], utils.get_main_process_name(app), app)
    )
end
