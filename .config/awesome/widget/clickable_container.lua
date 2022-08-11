local wibox = require("wibox")

-- create widget instance
local create_widget = function(widget)
	local old_cursor, old_wibox

	local container = wibox.widget({
		widget = wibox.container.background,
		{
			widget = wibox.container.margin,
			widget,
		},
	})

	container:connect_signal("mouse::enter", function()
		container.bg = "#ffffff11"
		local w = mouse.current_wibox
		if w then
			old_cursor, old_wibox = w.cursor, w
			w.cursor = "hand1"
		end
	end)
	container:connect_signal("mouse::leave", function()
		container.bg = "#ffffff00"
		if old_wibox then
			old_wibox.cursor = old_cursor
			old_wibox = nil
		end
	end)
	container:connect_signal("button::press", function()
		container.bg = "#ffffff22"
	end)
	container:connect_signal("button::release", function()
		container.bg = "#ffffff11"
	end)

	return container
end

return create_widget
