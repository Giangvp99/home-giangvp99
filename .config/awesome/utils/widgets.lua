-- requirements
-- ~~~~~~~~~~~~
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local widgets = {}
-- Barcontainer :
-- ~~~~~~~~~~~~~~
widgets.barcontainer_np = function(widget)
    local container = wibox.widget {
        {
            widget,
            widget = wibox.container.margin
        },
        bg = colors.container,
        shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, 4)
        end,
        widget = wibox.container.background
    }
    return wibox.widget {
        container,
        top = dpi(2),
        bottom = dpi(2),
        right = dpi(4),
        left = dpi(4),
        widget = wibox.container.margin
    }
end

widgets.barcontainer_wp = function(widget)
    local container = wibox.widget {
        widget,
        widget = wibox.container.margin
    }
    local box = wibox.widget {
        {
            container,
            left = dpi(4),
            right = dpi(4),
            widget = wibox.container.margin
        },

        bg = colors.container,
        shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, 4)
        end,
        widget = wibox.container.background
    }
    return wibox.widget {
        box,
        top = dpi(2),
        bottom = dpi(2),
        right = dpi(4),
        left = dpi(4),
        widget = wibox.container.margin
    }
end


-- Widgets :
-- ~~~~~~~~~
widgets.create_widget_icon = function(icon_symbol)
    local widget_icon = wibox.widget {
        text = icon_symbol,
        font = theme.iconfont,
        widget = wibox.widget.textbox,
    }
    local icon = wibox.widget {
        widget_icon,
        widget = wibox.container.background
    }
    return icon
end

widgets.create_widget_value = function()
    local widget_value = wibox.widget {
        font = theme.font,
        widget = wibox.widget.textbox,
    }
    local value = wibox.widget {
        widget_value,
        widget = wibox.container.background
    }
    return value
end

widgets.create_widget = function(widget_icon, widget_value, color)
    if color ~= nil then
        widget_icon.fg = color
        widget_value.fg = color
    end
    local widget = wibox.widget {
        widget_icon,
        widget_value,
        layout = wibox.layout.fixed.horizontal,
    }
    return widget

end

-- Scripts :
-- ~~~~~~~~~

-- get main process name
widgets.get_main_process_name = function(cmd)
    -- remove whitespace
    cmd = cmd:gsub("%s+$", "")

    local first_space_idx = cmd:find(" ")

    return first_space_idx ~= nil and cmd:sub(0, first_space_idx - 1) or cmd
end

-- start a monitoring script and monitor its output
widgets.start_monitor = function(script, callbacks)
    -- remove whitespace and escape quotes
    script = script:gsub("^%s+", ""):gsub("%s+$", ""):gsub('"', '\\"')

    local monitor_script = string.format([[ bash -c "%s" ]], script)
    local kill_monitor_script = string.format([[ pkill %s ]], widgets.get_main_process_name(script))

    -- First, kill any existing monitor processes
    awful.spawn.easy_async_with_shell(kill_monitor_script, function()
        -- Start monitor process
        awful.spawn.with_line_callback(monitor_script, callbacks)
    end)
end
-- Volume :
-- ~~~~~~~~
-- change volume
widgets.change_volume = function(change_by)
    local sinks_script = "pacmd list-sinks | awk '/\\* index: /{nr[NR+7];nr[NR+11]}; NR in nr'"
    awful.spawn.easy_async_with_shell(sinks_script, function(stdout)
        local volume = stdout:match("(%d+)%% /")

        if volume == nil then
            return
        end

        local volume_int = tonumber(volume)
        if (volume_int == 100 and change_by < 0) or volume_int < 100 then
            local percentage = change_by < 0 and string.format("-%s%%", -change_by) or string.format("+%s%%", change_by)

            local cmd = "pactl set-sink-volume @DEFAULT_SINK@ " .. percentage

            awful.spawn.with_shell(cmd)
        end
    end)
end

-- toggle volume mute
widgets.toggle_volume_mute = function()
    local cmd = "pactl set-sink-mute @DEFAULT_SINK@ toggle"
    awful.spawn.with_shell(cmd)
end

-- ========================================
-- Language
-- ========================================
-- get language map index
widgets.get_language_map_index = function(key, val)
    for i, pair in ipairs(Languages) do
        if pair[key] == val then
            return i
        end
    end

    return nil
end

-- get language from engine name
widgets.get_language = function(engine)
    local index = widgets.get_language_map_index("engine", engine)

    return index == nil and "unknown" or Languages[index].lang
end

-- get engine name from Language
widgets.get_engine = function(language)
    local index = widgets.get_language_map_index("lang", language)

    return index == nil and "unknown" or Languages[index].engine
end

-- set language
widgets.set_language = function(language)
    local engine = widgets.get_engine(language)
    local set_engine_script = "ibus engine " .. engine

    awful.spawn.easy_async_with_shell(set_engine_script, function()
        awesome.emit_signal("daemon::language", language)
    end)

end

-- switch language
widgets.switch_language = function()
    awful.spawn.easy_async_with_shell("ibus engine", function(stdout)
        local curr_index = widgets.get_language_map_index("engine", stdout:gsub("%s+", ""))

        local next_index = curr_index == #Languages and 1 or curr_index + 1
        local next_language = Languages[next_index].lang
        if next_language == 'en' then
            awful.spawn.with_shell("bash -c 'sleep 0.2 && xmodmap $HOME/.config/xmodmap/.Xmodmap'")
        end
        widgets.set_language(next_language)
    end)
end

widgets.brightness = function()
    awful.spawn.easy_async_with_shell('bash -c "brightnessctl get"', function(_, current)
        -- local brightness = string.match(stdout, "Current brightness: %d+ %((%d+)%%%)")
        awful.spawn.easy_async_with_shell('bash -c "brightnessctl max"', function(_, max)
            local brightness = math.floor(current / max * 100)
            awesome.emit_signal("daemon::brightness", brightness)
        end)
    end)
end

return widgets
