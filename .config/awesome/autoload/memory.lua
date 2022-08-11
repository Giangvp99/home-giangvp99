local watch = require('awful.widget.watch')
local round = function(exact, quantum)
    local quant, frac = math.modf(exact / quantum)
    return quantum * (quant + (frac > 0.5 and 1 or 0))
end

watch('bash -c "free | grep -z Mem.*Swap.*"', 2, function(_, stdout)
    local total, used, free, shared, buff_cache, available, total_swap, used_swap, free_swap =
    stdout:match('(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*Swap:%s*(%d+)%s*(%d+)%s*(%d+)')

    local value = round((used / 1048576), 0.1)
    awesome.emit_signal("autoload::memory", value)
    collectgarbage('collect')
end)
