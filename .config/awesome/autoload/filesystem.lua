local watch = require('awful.widget.watch')
watch('bash -c "df -h $HOME | awk \'/[0-9]/ {print $4}\' && df -h \'/\' | awk \'/[0-9]/ {print $4}\'"', 30,
    function(_, stdout)
        local home, root = stdout.match(stdout, "(%d+)G\n(%d+)")
        awesome.emit_signal("autoload::filesystem", home, root)
    end)
