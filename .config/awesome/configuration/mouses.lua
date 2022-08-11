-- ## Mousebindings ##
-- ~~~~~~~~~~~~~~~~~

-- requirements
-- ~~~~~~~~~~~~
local awful = require("awful")

-- Mouse bindings :
-- awful.mouse.append_global_mousebindings({
--     awful.button({}, 3, function() mymainmenu:toggle() end)
-- })

client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        awful.button({}, 1, function(c)
            c:activate { context = "mouse_click" }
        end),
        awful.button({ modkey }, 1, function(c)
            c:activate { context = "mouse_click", action = "mouse_move" }
        end),
        awful.button({ modkey }, 3, function(c)
            c:activate { context = "mouse_click", action = "mouse_resize" }
        end),
    })
end)

-- Sloppy focus :
--[[ client.connect_signal("mouse::enter", function(c)
    c:activate { context = "mouse_enter", raise = false }
end) ]]
