local wibox = require("wibox")

-- update widget
local update_widget = function(widget)
    widget.systray.visible = widget.show_systray
end

-- toggle systray visibility
local toggle_systray = function(widget)
    widget.show_systray = not widget.show_systray
    update_widget(widget)
end

-- create widget instance
local create_widget = function(screen)

    local systray = wibox.widget({
        widget = wibox.container.background,
        wibox.widget.systray(),
    })

    local wrapper = wibox.widget({
        layout = wibox.layout.fixed.horizontal,
        systray = systray,
        show_systray = false,
        systray,
    })

    systray.visible = false

    awesome.connect_signal("widget::systray::toggle", function()
        toggle_systray(wrapper)
    end)

    return wrapper
end

return create_widget
