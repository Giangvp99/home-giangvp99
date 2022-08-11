--
-- calendar.lua
-- clock/calendar widget
--

local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- create widget instance
local create_widget = function(screen)
	-- Clock Widget
	local clock_widget = wibox.widget({
		widget = wibox.widget.textclock,
		format = "%a %b %d %R",
		refresh = 30,
	})

	-- Calendar Widget
	local month_calendar = awful.widget.calendar_popup.month({
		screen = screen,
		start_sunday = true,
		long_weekdays = true,
		spacing = beautiful.calendar_spacing,
		style_month = {
			padding = theme.calendar_padding,
			border_width = theme.calendar_border_width,
			bg_color = theme.calendar_bg_1,
			shape = theme.calendar_shape
		},
		style_header = {
			border_width = theme.calendar_border_width,
			bg_color = theme.calendar_bg_2,
			shape = theme.calendar_shape
		},
		style_weekday = {
			border_width = theme.calendar_border_width,
			bg_color = theme.calendar_bg_1,
		},
		style_normal = {
			padding = theme.calendar_normal_padding,
			border_width = theme.calendar_border_width,
			bg_color = theme.calendar_bg_1,
		},
		style_focus = {
			border_width = theme.calendar_border_width,
			bg_color = theme.calendar_bg_1,
		}
	})

	-- Attach calendar to clock_widget
	month_calendar:attach(clock_widget, "tc")

	return clock_widget
end

return create_widget
