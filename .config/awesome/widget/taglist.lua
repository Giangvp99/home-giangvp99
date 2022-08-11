local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local wp = require("utils.widgets").barcontainer_wp
-- determine icon to show for each tag
local update_tag_icon = function(widget, tag)
	local icon = nil
	if #tag:clients() > 0 then
		if tag.selected then
            icon = theme.taglist_focus
		elseif tag.urgent then
            icon = theme.taglist_hidden
		else
            icon = theme.taglist_hidden
		end
	else --empty
		if tag.selected then
            icon = theme.taglist_focus
		elseif tag.urgent then
            icon = theme.taglist_empty
		else
            icon = theme.taglist_empty
		end
	end

	widget.markup = icon
end

-- create taglist widget instance
local create_widget = function(screen)
	return wibox.widget({
		widget = wibox.container.margin,
		awful.widget.taglist({
			screen = screen,
			filter = awful.widget.taglist.filter.all,
			layout = wibox.layout.fixed.horizontal,
			font = beautiful.taglist_font,
			widget_template = {
				widget = wibox.widget.textbox,
				valign = "center",
				align = "center",
				create_callback = update_tag_icon,
				update_callback = update_tag_icon,
			},
		}),
	})
end

return create_widget
