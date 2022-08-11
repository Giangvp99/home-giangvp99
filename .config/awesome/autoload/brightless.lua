local awful = require("awful")
local utils = require "utils.widgets"

local monitor_script = "inotifywait -mq -e modify /sys/class/backlight/*/brightness"

local emit_brightness = function()
    awful.spawn.easy_async_with_shell('brightnessctl', function(stdout)
        local brightness = string.match(stdout, "Current brightness: %d+ %((%d+)%%%)")
        awesome.emit_signal("daemon::brightness", brightness)
        collectgarbage('collect')
    end)
end

-- Run once to initialize widgets
emit_brightness()

-- Start monitoring process
utils.start_monitor(monitor_script, { stdout = emit_brightness })
