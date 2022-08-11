-- ## Temprature ##
-- ~~~~~~~~~~~~~~~~

-- requirements
-- ~~~~~~~~~~~~

local utils = require("utils.widgets")
local widget_icon = utils.create_widget_icon
local widget_value = utils.create_widget_value
local create_widget = utils.create_widget

-- vars
-- ~~~~
local temprature_icon = widget_icon('')
local temprature_value = widget_value()

local update_widget = function(widget, value)
    widget.widget.text = string.match(value, "%d+")
end
-- create widget instance
local temprature = create_widget(temprature_icon, temprature_value, colors.red)

awesome.connect_signal("autoload::temprature", function(...)
    update_widget(temprature_value, ...)
end)

return temprature
