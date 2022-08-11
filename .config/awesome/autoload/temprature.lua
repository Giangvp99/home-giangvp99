local watch = require('awful.widget.watch')
watch('bash -c "sensors | awk \'/Composite/ {print substr($2, 2) }\'"', 30, function(_, stdout)
    awesome.emit_signal("autoload::temprature", stdout)
end)
