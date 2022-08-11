-- requirements
-- ~~~~~~~~~~~~
local watch = require('awful.widget.watch')

-- vars
-- ~~~~
local updates_script = 'bash -c "yay -Qu | grep -Fcv "[ignored]" | sed "s/^//;s/^0$//g""'

watch(updates_script, 3600, function(_, stdout)
    local updates = stdout
    awesome.emit_signal("autoload::updates", updates)
    collectgarbage('collect')
end)
