local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- Create a tasklist widget
local tasklist_widget = function(s)
    return wibox.widget({
        widget = wibox.container.margin,
        awful.widget.tasklist {
            screen          = s,
            filter          = awful.widget.tasklist.filter.currenttags,
            --[[buttons         = {
                awful.button({}, 1, function(c)
                    c:activate { context = "tasklist", action = "toggle_minimization" }
                end),
                awful.button({}, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
                awful.button({}, 4, function() awful.client.focus.byidx(-1) end),
                awful.button({}, 5, function() awful.client.focus.byidx(1) end),
            }, ]]
            style           = {
                -- Text Enabeld :
                shape       = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 4) end,
                -- Text disabeld :
                --shape        = gears.shape.circle,
                bg_minimize = colors.black,
                bg_normal   = colors.brightblack,
                bg_focus    = colors.cyan,
            },
            layout          = {
                spacing        = 4,
                spacing_widget = {
                    {
                        forced_width = 0,
                        shape        = gears.shape.circle,
                        widget       = wibox.widget.separator
                    },
                    valign = "center",
                    halign = "center",
                    widget = wibox.container.place,
                },
                layout         = wibox.layout.flex.horizontal
            },
            widget_template = {
                {
                    {
                        {
                            -- Icon :
                            {
                                id     = "clienticon",
                                widget = awful.widget.clienticon,
                            },
                            margins = 2,
                            widget  = wibox.container.margin,
                        },
                        -- Text :
                        --{
                        --	id     = "text_role",
                        --	widget = wibox.widget.textbox,
                        --},
                        layout = wibox.layout.fixed.horizontal,
                    },
                    widget = wibox.container.margin
                },
                id     = "background_role",
                widget = wibox.container.background,
            },
        }
    })
end

local update_widget = function(widget, s)
    local size = 0
    local clients = {}
    for _, c in ipairs(s.clients) do
        table.insert(clients, c)
    end

    --[[ for _, c in ipairs(s.hidden_clients) do
        if not (c.skip_taskbar or c.hidden or c.type == "splash" or c.type == "dock" or c.type == "desktop")
            and c.minimized
            and awful.widget.tasklist.filter.currenttags(c, awful.screen.focused())
        then
            table.insert(clients, c)
        end
    end ]]
    if #clients > 0 then
        size = 3
    end
    widget.left = dpi(size)
    widget.right = dpi(size)
    widget.top = dpi(size)
    widget.bottom = dpi(size)
    return widget
end


local create_widget = function(s)
    local widget = tasklist_widget(s)
    client.connect_signal("unmanage", function()
        update_widget(widget, s)
    end)
    client.connect_signal("manage", function()
        update_widget(widget, s)
    end)
    client.connect_signal("focus", function()
        update_widget(widget, s)
    end)
    client.connect_signal("swapped", function()
        update_widget(widget, s)
    end)
    client.connect_signal("property::minimized", function()
        update_widget(widget, s)
    end)
    client.connect_signal("property::hidden", function()
        update_widget(widget, s)
    end)
    client.connect_signal("property::floating", function()
        update_widget(widget, s)
    end)
    client.connect_signal("property::maximized", function()
        update_widget(widget, s)
    end)
    client.connect_signal("property::ontop", function()
        update_widget(widget, s)
    end)
    awful.tag.attached_connect_signal(s, "property::selected", function()
        update_widget(widget, s)
    end)
    return widget
end
return create_widget
