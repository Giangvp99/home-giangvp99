-- ## Memory ##
-- ~~~~~~~~~

-- requirements
-- ~~~~~~~~~~~~
local utils = require("utils.widgets")
local widget_icon = utils.create_widget_icon
local widget_value = utils.create_widget_value
local create_widget = utils.create_widget

-- vars
-- ~~~~
local memory_icon = widget_icon(" ")
local memory_value = widget_value()

local update_widget = function(widget, percentage)
    widget.widget.text = percentage
end

local memory = create_widget(memory_icon, memory_value, colors.blue)

awesome.connect_signal("autoload::memory", function(...)
    update_widget(memory_value, ...)
end)

return memory
