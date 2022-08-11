local awful = require("awful")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local create_widget = function(s)
    return wibox.widget({
        widget = wibox.container.margin,
        top = dpi(4),
        bottom = dpi(4),
        awful.widget.layoutbox {
            screen  = s,
            visible = true,
            --[[ buttons = {
                awful.button({}, 1, function() awful.layout.inc(1) end),
                awful.button({}, 3, function() awful.layout.inc(-1) end),
                awful.button({}, 4, function() awful.layout.inc(-1) end),
                awful.button({}, 5, function() awful.layout.inc(1) end),
            } ]]
        }
    })
end
return create_widget
