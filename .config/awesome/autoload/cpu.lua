local watch = require('awful.widget.watch')
local total_prev = 0
local idle_prev = 0

watch([[bash -c "cat /proc/stat | grep '^cpu '"]], 2, function(_, stdout)
    local user, nice, system, idle, iowait, irq, softirq, steal, guest, guest_nice =
    stdout:match('(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s')

    local total = user + nice + system + idle + iowait + irq + softirq + steal

    local diff_idle = idle - idle_prev
    local diff_total = total - total_prev
    local diff_usage = (1000 * (diff_total - diff_idle) / diff_total + 5) / 10

    awesome.emit_signal("autoload::cpu", diff_usage)

    total_prev = total
    idle_prev = idle
    collectgarbage('collect')
end)
