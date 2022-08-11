-- requirements
-- ~~~~~~~~~~~~
local awful = require("awful")

-- vars :
local move_client = require("utils.ui").move_client
-- Configurations
-- ~~~~~~~~~~~~~~

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        -- move between clients
        awful.key({ modkey, }, "j", function(c) move_client(c, 'down') end,
            { description = "move down", group = "clients" }
        ),
        awful.key({ modkey, }, "k", function(c) move_client(c, 'up') end,
            { description = "move up", group = "clients" }
        ),
        awful.key({ modkey, }, "l", function(c) move_client(c, "right") end,
            { description = "move left", group = "clients" }),

        awful.key({ modkey, }, "h", function(c) move_client(c, "left") end,
            { description = "move right", group = "clients" }),
        --
        awful.key({ modkey, }, "q", function(c) c:kill() end,
            { description = "close", group = "client" }),
        awful.key({ modkey, }, "f",
            function(c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            { description = "toggle fullscreen", group = "client" }),
        awful.key({ modkey, shift }, "f", awful.client.floating.toggle,
            { description = "toggle floating", group = "client" }),
        awful.key({ modkey, shift }, "m", function(c) c:swap(awful.client.getmaster()) end,
            { description = "move to master", group = "clent" }),
        awful.key({ modkey, }, "o", function(c) c.ontop = not c.ontop end,
            { description = "toggle keep on top", group = "client" }),
        awful.key({ modkey, }, "n",
            function(c)
                -- The client currently has the input focus, so it cannot be
                -- minimized, since minimized clients can't have the focus.
                c.minimized = true
            end,
            { description = "minimize", group = "client" }),
        awful.key({ modkey, }, "m",
            function(c)
                c.maximized = not c.maximized
                c:raise()
            end,
            { description = "(un)maximize", group = "client" }),
        --[[ awful.key({ modkey, ctrl }, "m",
            function(c)
                c.maximized_vertical = not c.maximized_vertical
                c:raise()
            end,
            { description = "(un)maximize vertically", group = "client" }),
        awful.key({ modkey, shift }, "m",
            function(c)
                c.maximized_horizontal = not c.maximized_horizontal
                c:raise()
            end,
            { description = "(un)maximize horizontally", group = "client" }), ]]
    })
end)
