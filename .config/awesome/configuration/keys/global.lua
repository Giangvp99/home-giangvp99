-- requirements
-- ~~~~~~~~~~~~
local awful         = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")

-- vars
local resize_client = require("utils.ui").resize_client
local enter_key = "Return"
local esc = "Escape"
local utils = require("utils.widgets")
-- Configurations
-- ~~~~~~~~~~~~~~

-- General AwesomeWM
awful.keyboard.append_global_keybindings({
    awful.key({ modkey, shift }, "/", hotkeys_popup.show_help,
        { description = "show help", group = "awesome" }),

    awful.key({ modkey, ctrl }, "r", awesome.restart,
        { description = "reload awesome", group = "awesome" }),

    awful.key({ modkey, ctrl }, "q", awesome.quit,
        { description = "quit awesome", group = "awesome" }),

})

-- Tags related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey, }, ".", awful.tag.viewnext,
        { description = "view next", group = "tag" }),

    awful.key({ modkey, }, ",", awful.tag.viewprev,
        { description = "view previous", group = "tag" }),

    awful.key({ modkey, }, "/", awful.tag.history.restore,
        { description = "go back", group = "tag" }),
})


awful.keyboard.append_global_keybindings({
    awful.key({ modkey, }, "Tab",
        function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        { description = "go back", group = "clients" }),
    awful.key({ modkey, shift }, "n",
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:activate { raise = true, context = "key.unminimize" }
            end
        end,
        { description = "restore minimized", group = "client" }),

    awful.key({ modkey, shift }, ",", function() awful.client.swap.byidx(1) end,
        { description = "swap with next client by index", group = "clients" }),

    awful.key({ modkey, shift }, ".", function() awful.client.swap.byidx(-1) end,
        { description = "swap with previous client by index", group = "clients" }),

    awful.key({ modkey, }, "u", awful.client.urgent.jumpto,
        { description = "jump to urgent client", group = "client" }),
    awful.key({ modkey, shift }, "j", function()
        resize_client(client.focus, "down")
    end,
        { description = "resize down", group = "client" }
    ),
    awful.key({ modkey, shift }, "k", function()
        resize_client(client.focus, "up")
    end,
        { description = "resize up", group = "client" }
    ),
    awful.key({ modkey, shift }, "h", function()
        resize_client(client.focus, "left")
    end,
        { description = "resize left", group = "client" }
    ),
    awful.key({ modkey, shift }, "l", function()
        resize_client(client.focus, "right")
    end,
        { description = "resize right", group = "client" }
    ),

    awful.key({ modkey, shift }, ".", function() awful.layout.inc(1) end,
        { description = "select next", group = "layout" }),

    awful.key({ modkey, shift }, ",", function() awful.layout.inc(-1) end,
        { description = "select previous", group = "layout" }),
})

awful.keyboard.append_global_keybindings({
    awful.key {
        modifiers   = { modkey },
        keygroup    = "numrow",
        description = "only view tag",
        group       = "tag",
        on_press    = function(index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },
    awful.key {
        modifiers   = { modkey, shift },
        keygroup    = "numrow",
        description = "move focused client to tag",
        group       = "tag",
        on_press    = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { modkey, ctrl },
        keygroup    = "numrow",
        description = "toggle focused client on tag",
        group       = "tag",
        on_press    = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end,
    },
})

-- Media Control :
awful.keyboard.append_global_keybindings({
    -- Volume Keys :
    awful.key({}, "XF86AudioLowerVolume", function()
        utils.change_volume(-5)
    end),

    awful.key({}, "XF86AudioRaiseVolume", function()
        utils.change_volume(5)
    end),

    awful.key({}, "XF86AudioMute", function()
        utils.toggle_volume_mute()
    end),

    -- Media Keys :
    awful.key({}, "XF86AudioPlay", function()
        awful.util.spawn("playerctl play-pause", false)
    end),

    awful.key({}, "XF86AudioNext", function()
        awful.util.spawn("playerctl next", false)
    end),

    awful.key({}, "XF86AudioPrev", function()
        awful.util.spawn("playerctl previous", false)
    end),

    -- Brightness Keys :
    awful.key({}, "XF86MonBrightnessUp", function()
        awful.util.spawn("brightnessctl set 2%+", false)
        utils.brightness()
    end),

    awful.key({}, "XF86MonBrightnessDown", function()
        awful.util.spawn("brightnessctl set 2%-", false)
        utils.brightness()
    end),

    awful.key({ shift }, "Control_L", function()
        local caplock_script = "bash -c 'sleep 0.2 && xset q'"
        awful.spawn.easy_async_with_shell(caplock_script, function(stdout)
            if stdout:match("Caps Lock") then
                local status = stdout:gsub(".*(Caps Lock:%s+)(%a+).*", "%2")
                awesome.emit_signal("autoload::capslock", status)
            end
        end)
    end),
    awful.key({}, "Caps_Lock", function()
        local caplock_script = "bash -c 'sleep 0.2 && xset q'"
        awful.spawn.easy_async_with_shell(caplock_script, function(stdout)
            if stdout:match("Caps Lock") then
                local status = stdout:gsub(".*(Caps Lock:%s+)(%a+).*", "%2")
                awesome.emit_signal("autoload::capslock", status)
            end
        end)
    end)
})

-- Launcher programs :
awful.keyboard.append_global_keybindings({
    awful.key({ modkey, shift }, enter_key, function() awful.spawn(terminal) end,
        { description = "open a terminal", group = "launcher" }),

    awful.key({ modkey }, enter_key, function()
        awesome.emit_signal("floating_terminal::toggle")
    end, { description = "toggle floating terminal", group = "launcher" }),

    awful.key({ modkey }, esc, function()
        awesome.emit_signal("exit_screen::show")
    end, { description = "show exit screen", group = "launcher" }),

    --[[ awful.key({ modkey }, "p", function() menubar.show() end,
        { description = "show the menubar", group = "launcher" }), ]]

    awful.key({ modkey, }, "w", function() mymainmenu:show() end,
        { description = "show main menu", group = "launcher" }),

})

-- Standard program :
awful.keyboard.append_global_keybindings({
    -- File Manager :
    awful.key({ ctrl, shift }, "f", function() awful.spawn(string.format("pcmanfm")) end,
        { description = "pcmanfm", group = "file manager" }),

    -- Screenshots Keys :
    awful.key({}, "Print", function() awful.util.spawn("screenshot") end,
        { description = "Maim", group = "screenshot" }),

    awful.key({ modkey }, "Print", function() awful.util.spawn("screenshot-select") end,
        { description = "Maim", group = "screenshot" }),

    -- Rofi :
    awful.key({ modkey }, "'", function() awful.spawn(string.format("rofi -show run -show-icons")) end,
        { description = "rofi launcher", group = "launcher" }),

    -- Firefox :
    awful.key({ modkey }, "b", function() awful.spawn(string.format("firefox")) end,
        { description = "browser launcher", group = "launcher" }),

    -- Center Window :
    awful.key({ modkey }, "y", awful.placement.centered),

})

-- Systray :
awful.keyboard.append_global_keybindings({
    awful.key({ modkey }, "s", function()
        awesome.emit_signal("widget::systray::toggle")
    end, { description = "Toggle systray visibility", group = "custom" }),
    awful.key({ modkey }, "space", utils.switch_language, { description = "switch language", group = "hotkeys" }),
})

-- Screen
--[[ awful.keyboard.append_global_keybindings({
    awful.key({ modkey, ctrl }, "j", function() awful.screen.focus_relative(1) end,
        { description = "focus the next screen", group = "screen" }),

    awful.key({ modkey, ctrl }, "k", function() awful.screen.focus_relative(-1) end,
        { description = "focus the previous screen", group = "screen" }),
}) ]]
-- ========================================
-- Language
-- ========================================
