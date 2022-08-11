-- ## Updates ##
-- ~~~~~~~~~~~~~

-- requirements
-- ~~~~~~~~~~~~

local utils = require("utils.widgets")
local widget_icon = utils.create_widget_icon
local widget_value = utils.create_widget_value
local create_widget = utils.create_widget

-- vars
-- ~~~~
local updates_icon = widget_icon(' ')
local updates_value = widget_value()

local update_widget = function(widget, updates)
    widget.widget.text = updates
end
-- create widget instance
local updates = create_widget(updates_icon, updates_value, colors.green)

awesome.connect_signal("autoload::updates", function(...)
    update_widget(updates_value, ...)
end)

return updates
