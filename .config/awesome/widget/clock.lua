-- ## Clock ##
-- ~~~~~~~~~~~~~

-- requirements
-- ~~~~~~~~~~~~
local wibox = require('wibox')
local beautiful = require('beautiful')
local dpi = require('beautiful').xresources.apply_dpi

local clock = wibox.widget.textclock('<span font="' .. theme.font .. '">%a %d %b | %H:%M</span>')
--return clock
clock_icon = wibox.widget {
	markup = '<span font="' .. theme.iconfont .. '"> </span>',
	widget = wibox.widget.textbox,
}

return wibox.widget {
	wibox.widget{
		clock_icon,
		fg = colors.brightmagenta,
		widget = wibox.container.background
	},
    wibox.widget{
        clock, 
        fg = colors.brightmagenta,
        widget = wibox.container.background
    },
    spacing = dpi(2),
    layout = wibox.layout.fixed.horizontal
}
