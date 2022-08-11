local awful = require("awful")

local caplock_script = "bash -c 'sleep 0.2 && xset q'"

awful.spawn.easy_async_with_shell(caplock_script, function(stdout)
    if stdout:match("Caps Lock") then
        local status = stdout:gsub(".*(Caps Lock:%s+)(%a+).*", "%2")
        awesome.emit_signal("autoload::capslock", status)
    end
end)
