local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local utils = require("utils.widgets")
local np = utils.barcontainer_np
local wp = utils.barcontainer_wp

awful.screen.connect_for_each_screen(function(s)
	s.topbar = awful.wibar({
		position = "top",
		type = "dock",
		ontop = false,
		stretch = false,
		visible = true,
		height = dpi(30),
		width = s.geometry.width,
		screen = s,
		bg = colors.transparent,
	})

	awful.placement.top(s.topbar, { margins = dpi(0) })
	s.topbar:struts({
		top = dpi(36),
		bottom = dpi(4),
		left = dpi(4),
		right = dpi(4)
	})
	-- Widgets
	-- ~~~~~~~
	local taglist = require("widget.taglist")(s)
	local capslock = require("widget.capslock")
	local filesystem = require("widget.filesystem")
	local tasklist = require("widget.tasklist")(s)
	local calendar = require("widget.calendar")(s)
	local systray = require("widget.systray")(s)
	local cpu = require("widget.cpu")
	local mem = require("widget.memory")
	local temp = require("widget.temprature")
	local vol = require("widget.volume")
	local bright = require("widget.brightness")
	local updates = require("widget.updates")
	local keyboard = require("widget.keyboardlayout")
	local bat = require("widget.battery")
	local layout = require("widget.layoutbox")(s)
	s.topbar:setup({
		{
			{
				layout = wibox.layout.align.horizontal,
				expand = "none",
				{ -- Left widgets :
					wp(taglist),
					wp(capslock),
					wp(filesystem),
					np(tasklist),
					layout = wibox.layout.fixed.horizontal,
				},
				{ -- Middle widget :
					wp(calendar),
					layout = wibox.layout.align.horizontal,
				},
				{ -- Right widgets :
					np(systray),
					wp(cpu),
					wp(mem),
					wp(temp),
					wp(vol),
					wp(bright),
					wp(updates),
					wp(keyboard),
					wp(bat),
					wp(layout),
					layout = wibox.layout.fixed.horizontal,
				},
			},
			left = dpi(4),
			right = dpi(4),
			widget = wibox.container.margin,
		},
		bg     = colors.black,
		shape  = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 0) end,
		widget = wibox.container.background,

	})
end)
