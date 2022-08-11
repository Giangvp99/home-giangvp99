-- ## Cpu ##
-- ~~~~~~~~~

-- requirements
-- ~~~~~~~~~~~~

local utils = require("utils.widgets")
local widget_icon = utils.create_widget_icon
local widget_value = utils.create_widget_value
local create_widget = utils.create_widget


-- vars
-- ~~~~
local cpu_icon = widget_icon(" ")
local cpu_value = widget_value()

local update_widget = function(widget, percentage)
    local value = math.floor(percentage) .. ""
    if percentage < 10 then
        value = "0" .. value
    end
    widget.widget.text = value
end

local cpu = create_widget(cpu_icon, cpu_value, colors.blue)

awesome.connect_signal("autoload::cpu", function(...)
    update_widget(cpu_value, ...)
end)

return cpu
