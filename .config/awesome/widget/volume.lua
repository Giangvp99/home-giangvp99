-- ## Volume ##
-- ~~~~~~~~~~~~

-- requirements
-- ~~~~~~~~~~~~

local utils = require("utils.widgets")
local widget_icon = utils.create_widget_icon
local widget_value = utils.create_widget_value
local create_widget = utils.create_widget
-- vars
-- ~~~~
local volume_icon = widget_icon('墳 ')
local volume_value = widget_value()

local update_widget = function(icon, value, percentage)
    if percentage < 10 then
        value.widget.text = "0" .. percentage
    else
        value.widget.text = percentage
    end
    if percentage > 70 then
        icon.widget.text = ' '
    elseif percentage > 35 and percentage <= 70 then
        icon.widget.text = '墳 '
    elseif percentage <= 35 and percentage > 1 then
        icon.widget.text = '奔 '
    elseif percentage == -1 then
        icon.widget.text = '婢 '
        value.widget.text = ""
    elseif percentage < 1 then
        icon.widget.text = '奄 '
    end
end

-- create widget instance
local volume = create_widget(volume_icon, volume_value, colors.yellow)

awesome.connect_signal("autoload::volume::muted", function(...)
    update_widget(volume_icon, volume_value, -1)
end)
awesome.connect_signal("autoload::volume::percentage", function(...)
    update_widget(volume_icon, volume_value, ...)
end)

return volume
