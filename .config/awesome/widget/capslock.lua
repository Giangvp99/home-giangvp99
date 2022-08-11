-- ## Caplock ##
-- ~~~~~~~~~~~~~

-- requirements
-- ~~~~~~~~~~~~
local utils = require("utils.widgets")
local widget_icon = utils.create_widget_icon
local widget_value = utils.create_widget_value
local create_widget = utils.create_widget
-- vars
-- ~~~~
local caps_icon = widget_icon('')
local caps_value = widget_value()

local update_widget = function(widget, status)
    if status == "off" then
        widget.fg = colors.white
    elseif status == "on" then
        widget.fg = colors.yellow
    end
end

-- create widget instance
local caps = create_widget(caps_icon, caps_value, colors.yellow)

awesome.connect_signal("autoload::capslock", function(...)
    update_widget(caps_icon, ...)
end)

return caps
