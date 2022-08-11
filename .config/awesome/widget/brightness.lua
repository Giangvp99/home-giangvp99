-- ## Brightness ##
-- ~~~~~~~~~~~~~

-- requirements
-- ~~~~~~~~~~~~

local utils = require("utils.widgets")
local widget_icon = utils.create_widget_icon
local widget_value = utils.create_widget_value
local create_widget = utils.create_widget

-- vars
-- ~~~~
local brightness_icon = widget_icon(' ')
local brightness_value = widget_value()

local update_widget = function(widget, brightness)
    if tonumber(brightness) < 10 then
        brightness = "0" .. brightness
    end
    widget.widget.text = brightness
end
-- create widget instance
local updates = create_widget(brightness_icon, brightness_value, colors.blue)

awesome.connect_signal("daemon::brightness", function(...)
    update_widget(brightness_value, ...)
end)

return updates
