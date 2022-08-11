local awful = require("awful")
local utils = {}
-- ========================================
-- Scripts
-- ========================================

-- get main process name
utils.get_main_process_name = function(cmd)
    -- remove whitespace
    cmd = cmd:gsub("%s+$", "")

    local first_space_idx = cmd:find(" ")

    return first_space_idx ~= nil and cmd:sub(0, first_space_idx - 1) or cmd
end

return utils
