-- Theme handling library
local beautiful = require("beautiful")

-- Themes :

-- choose your theme here
--[[ local accents = {
    "otis-forest",			-- 1
    "kripton",				-- 2
    "hornet",				-- 3
	"cherry-blossom",		-- 4
} ]]
-- choose your theme here
-- local chosen_accents = accents[2]
-- local theme_path = string.format("%s/.config/awesome/themes/accents/%s.lua", os.getenv("HOME"), chosen_accents)
local theme_path = string.format("%s/.config/awesome/theme/theme.lua", os.getenv("HOME"))
beautiful.init(theme_path)