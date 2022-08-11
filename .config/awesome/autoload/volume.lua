---@diagnostic disable: cast-local-type
local awful = require("awful")
local utils = require("utils.widgets")

local monitor_script = [[ pactl subscribe 2> /dev/null | grep --line-buffered "Event 'change' on sink #" ]]

local sinks_script = "pacmd list-sinks | awk '/\\* index: /{nr[NR+7];nr[NR+11]}; NR in nr'"

local volume_old = -1
local muted_old  = -1

local emit_volume = function()
    awful.spawn.easy_async_with_shell(sinks_script, function(stdout)
        local volume = stdout:match("(%d+)%% /")
        local muted = stdout:match("muted:%s+yes")

        if volume == nil then
            return
        end

        local muted_int = muted and 1 or 0
        local volume_int = tonumber(volume)
        if volume_int ~= volume_old or (muted_int ~= muted_old and muted_int == 0) then
            awesome.emit_signal("autoload::volume::percentage", volume_int)
            volume_old = volume_int
            muted_old = muted_int
        end

        if muted_int ~= muted_old and muted_int == 1 then
            awesome.emit_signal("autoload::volume::muted")
            muted_old = muted_int
        end
    end)
end

-- Run once to initialize widgets
emit_volume()

-- Start monitoring process
utils.start_monitor(monitor_script, { stdout = emit_volume })
