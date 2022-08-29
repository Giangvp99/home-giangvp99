local colorscheme = "onedarkpro"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	-- vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end

require("onedarkpro").setup({
	dark_theme = "onedark", -- The default dark theme
	styles = { -- Choose from "bold,italic,underline"
		strings = "NONE", -- Style that is applied to strings.
		comments = "NONE", -- Style that is applied to comments
		keywords = "NONE", -- Style that is applied to keywords
		functions = "NONE", -- Style that is applied to functions
		variables = "NONE", -- Style that is applied to variables
		virtual_text = "NONE", -- Style that is applied to virtual text
	},
	options = {
		bold = true, -- Use the colorscheme's opinionated bold styles?
		italic = true, -- Use the colorscheme's opinionated italic styles?
		underline = false, -- Use the colorscheme's opinionated underline styles?
		undercurl = true, -- Use the colorscheme's opinionated undercurl styles?
		cursorline = false, -- Use cursorline highlighting?
		transparency = false, -- Use a transparent background?
		terminal_colors = false, -- Use the colorscheme's colors for Neovim's :terminal?
		window_unfocused_color = false, -- When the window is out of focus, change the normal background?
	},
})
