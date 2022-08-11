local utils = require("utils")
local awful = require('awful')
local keyboardlayout_script = 'ibus engine'
awful.spawn.easy_async_with_shell(keyboardlayout_script, function(stdout)
    local language = utils.get_language(stdout:gsub("%s+", ""))
    awesome.emit_signal("daemon::language", language)
end)
