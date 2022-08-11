-- ## KeyboardLayout ##
-- ~~~~~~~~~~~~~~~~~~~~

-- requirements
-- ~~~~~~~~~~~~
local awful = require("awful")
local gears = require("gears")
local utils = require("utils.widgets")
local widget_icon = utils.create_widget_icon
local widget_value = utils.create_widget_value
local create_widget = utils.create_widget

-- vars
-- ~~~~
local keyboard_icon = widget_icon(" ")
local keyboard_value = widget_value()

-- define buttons
local buttons = function()
    return gears.table.join(
        awful.button({}, leftclick, utils.switch_language),
        awful.button({}, rightclick, function()
            awful.spawn("ibus-setup")
        end)
    )
end


local update_widget = function(widget, language)
    widget.widget.text = language
end

local keyboard = create_widget(keyboard_icon, keyboard_value, colors.brightyellow)

awesome.connect_signal("daemon::language", function(...)
    update_widget(keyboard_value, ...)
end)

--local container = require("widget.clickable_container")(keyboard_widget)
--container:buttons(buttons())


return keyboard
