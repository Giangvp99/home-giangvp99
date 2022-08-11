-- ## Storage ##
-- ~~~~~~~~~~~~~

-- requirements
-- ~~~~~~~~~~~~
local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local utils = require("utils.widgets")
local widget_icon = utils.create_widget_icon
local widget_value = utils.create_widget_value
local create_widget = utils.create_widget

-- vars
-- ~~~~
local home_icon = widget_icon(' ')
local home_free = widget_value()

local root_icon = widget_icon(' ')
local root_free = widget_value()

local update_widget = function(home, root, home_value, root_value)
    home.widget.text = home_value
    root.widget.text = root_value
end
-- create widget instance
local home = create_widget(home_icon, home_free, colors.blue)
local root = create_widget(root_icon, root_free, colors.blue)

awesome.connect_signal("autoload::filesystem", function(...)
    update_widget(home_free, root_free, ...)
end)

return wibox.widget {
    home,
    root,
    spacing = dpi(10),
    layout = wibox.layout.fixed.horizontal
}
