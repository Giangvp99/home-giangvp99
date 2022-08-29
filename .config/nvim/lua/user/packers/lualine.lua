M = {}
local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local icons = require("user.packers.icons")
-- check if value in table
local function contains(t, value)
	for _, v in pairs(t) do
		if v == value then
			return true
		end
	end
	return false
end

local gray = "#32363e"
local dark_gray = "#222224"
local red = "#D16969"
local blue = "#569CD6"
local green = "#6A9955"
local cyan = "#4EC9B0"
local orange = "#CE9178"
local indent = "#CE9178"
local yellow = "#DCDCAA"
local yellow_orange = "#D7BA7D"
local purple = "#C586C0"

local hide_in_width_60 = function()
	return vim.o.columns > 60
end

local hide_in_width = function()
	return vim.o.columns > 80
end

local hide_in_width_100 = function()
	return vim.o.columns > 100
end
local hl_str = function(str, hl)
	return "%#" .. hl .. "#" .. str .. "%*"
end

vim.api.nvim_set_hl(0, "SLBranchName", { fg = cyan, bg = gray, bold = false })
vim.api.nvim_set_hl(0, "SLIndent", { fg = indent, bg = gray })
vim.api.nvim_set_hl(0, "SLLSP", { fg = "#6b727f", bg = gray })
vim.api.nvim_set_hl(0, "SLSep", { fg = gray, bg = dark_gray })
vim.api.nvim_set_hl(0, "SLFT", { fg = cyan, bg = gray })
local left_sep = {
	function()
		return hl_str(" ", "SLSep")
	end,
	padding = 0,
}
local right_sep = {
	function()
		return hl_str(" ", "SLSep")
	end,
	padding = 0,
}
local mode_color = {
	n = blue,
	i = orange,
	v = "#b668cd",
	[""] = "#b668cd",
	V = "#b668cd",
	-- c = '#B5CEA8',
	-- c = '#D7BA7D',
	c = "#46a6b2",
	no = "#D16D9E",
	s = green,
	S = orange,
	[""] = orange,
	ic = red,
	R = "#D16D9E",
	Rv = red,
	cv = blue,
	ce = blue,
	r = red,
	rm = "#46a6b2",
	["r?"] = "#46a6b2",
	["!"] = "#46a6b2",
	t = red,
}
local mode = {
	function()
		return " "
	end,
	color = function()
		-- auto change color according to neovims mode
		return { fg = mode_color[vim.fn.mode()], bg = dark_gray }
	end,
	padding = 0,
}

local branch = {
	"branch",
	icons_enabled = false,
	fmt = function(str)
		if str == "" or str == nil then
			return hl_str("", "SLBranchName")
		end

		return hl_str(" " .. str, "SLBranchName")
	end,
	padding = 0,
}
local diff = {
	"diff",
	colored = true,
	symbols = { added = icons.git.Add .. " ", modified = icons.git.Mod .. " ", removed = icons.git.Remove .. " " }, -- changes diff symbols
	diff_color = {
		added = { fg = green, bg = gray },
		modified = { fg = orange, bg = gray },
		removed = { fg = red, bg = gray },
	},
	padding = { left = 1, right = 0 },
	always_visible = true,
}
local filename = {
	"filename",
	file_status = true, -- Displays file status (readonly status, modified status)
	newfile_status = false, -- Display new file status (new file means no write after created)
	path = 1, -- 0: Just the filename
	-- 1: Relative path
	-- 2: Absolute path
	-- 3: Absolute path, with tilde as the home directory
	shorting_target = 40, -- Shortens path to leave 40 spaces in the window
	-- for other components. (terrible name, any suggestions?)
	symbols = {
		modified = " פֿ", -- Text to show when the file is modified.
		readonly = " ", -- Text to show when the file is non-modifiable or readonly.
		newfile = "", -- Text to show for new created file before first writting
	},
	disabled_filetypes = "NvimTree",
	fmt = function(str)
		if str == "[No Name]" then
			return ""
		elseif str == "NvimTree_1 " then
			return " NvimTree"
		end
		return " " .. str
	end,
	padding = 0,
	color = { fg = red, bg = gray },
}

local filesize = {
	"filesize",
	padding = { right = 0, left = 1 },
	color = { bg = gray },
}
local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn", "info", "hint" },
	symbols = {
		error = icons.diagnostics.Error .. " ",
		warn = icons.diagnostics.Warning .. " ",
		hint = icons.diagnostics.Hint .. " ",
		info = icons.diagnostics.Information .. " ",
	},
	update_in_insert = false,
	always_visible = true,
	padding = 0,
	color = { bg = gray },
}

local filetype = {
	"filetype",
	fmt = function(str)
		local ui_filetypes = {
			"help",
			"packer",
			"neogitstatus",
			"NvimTree",
			"Trouble",
			"lir",
			"Outline",
			"spectre_panel",
			"toggleterm",
			"DressingSelect",
			"",
			"nil",
		}

		local return_val = function(str)
			return hl_str(" ", "SLSep") .. hl_str(str, "SLFT") .. hl_str("", "SLSep")
		end

		if str == "TelescopePrompt" then
			return return_val(icons.ui.Telescope)
		end

		local function get_term_num()
			local t_status_ok, toggle_num = pcall(vim.api.nvim_buf_get_var, 0, "toggle_number")
			if not t_status_ok then
				return ""
			end
			return toggle_num
		end

		if str == "toggleterm" then
			-- 
			local term = "%#SLTermIcon#" .. " " .. "%*" .. "%#SLFT#" .. get_term_num() .. "%*"

			return return_val(term)
		end

		if contains(ui_filetypes, str) then
			return ""
		else
			return return_val(str)
		end
	end,
	icons_enabled = false,
	padding = 0,
}
local lanuage_server = {
	function()
		local buf_ft = vim.bo.filetype
		local ui_filetypes = {
			"help",
			"packer",
			"neogitstatus",
			"NvimTree",
			"Trouble",
			"lir",
			"Outline",
			"spectre_panel",
			"toggleterm",
			"DressingSelect",
			"TelescopePrompt",
			"lspinfo",
			"lsp-installer",
			"",
		}

		if contains(ui_filetypes, buf_ft) then
			if M.language_servers == nil then
				return ""
			else
				return M.language_servers
			end
		end

		local clients = vim.lsp.buf_get_clients()
		local client_names = {}
		local copilot_active = false

		-- add client
		for _, client in pairs(clients) do
			if client.name ~= "copilot" and client.name ~= "null-ls" then
				table.insert(client_names, client.name)
			end
			if client.name == "copilot" then
				copilot_active = true
			end
		end

		-- add formatter
		local s = require("null-ls.sources")
		local available_sources = s.get_available(buf_ft)
		local registered = {}
		for _, source in ipairs(available_sources) do
			for method in pairs(source.methods) do
				registered[method] = registered[method] or {}
				table.insert(registered[method], source.name)
			end
		end

		local formatter = registered["NULL_LS_FORMATTING"]
		local linter = registered["NULL_LS_DIAGNOSTICS"]
		if formatter ~= nil then
			vim.list_extend(client_names, formatter)
		end
		if linter ~= nil then
			vim.list_extend(client_names, linter)
		end

		-- join client names with commas
		local client_names_str = table.concat(client_names, ", ")

		-- check client_names_str if empty
		local language_servers = ""
		local client_names_str_len = #client_names_str
		if client_names_str_len ~= 0 then
			language_servers = hl_str(" ", "SLSep") .. hl_str(client_names_str, "SLLSP") .. hl_str(" ", "SLSep")
		end
		-- if copilot_active then
		-- 	language_servers = language_servers .. "%#SLCopilot#" .. " " .. icons.git.Octoface .. "%*"
		-- end
		--
		if client_names_str_len == 0 and not copilot_active then
			return ""
		else
			M.language_servers = language_servers
			return language_servers:gsub(", anonymous source", "")
		end
	end,
	padding = 0,
	-- separator = "%#SLSeparator#" .. " │" .. "%*",
}
local spaces = {
	function()
		local buf_ft = vim.bo.filetype

		local ui_filetypes = {
			"help",
			"packer",
			"neogitstatus",
			"NvimTree",
			"Trouble",
			"lir",
			"Outline",
			"spectre_panel",
			"DressingSelect",
			"",
		}
		local space = ""

		if contains(ui_filetypes, buf_ft) then
			space = " "
		end

		local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")

		if shiftwidth == nil then
			return ""
		end

		-- TODO: update codicons and use their indent
		return hl_str(" ", "SLSep") .. hl_str(" " .. shiftwidth .. space, "SLIndent") .. hl_str(" ", "SLSep")
	end,
	padding = 0,
	-- separator = "%#SLSeparator#" .. " │" .. "%*",
	-- cond = hide_in_width_100,
}
local location = {
	"location",
	fmt = function()
		local line = vim.fn.line(".")
		local col = vim.fn.col(".")
		local total = vim.fn.line("$")
		return string.format("%2d/%2d:%-2d", line, total, col)
	end,
	padding = 0,
	color = { bg = gray },
}

local buffers = {
	"buffers",
	show_filename_only = true, -- Shows shortened relative path when set to false.
	hide_filename_extension = false, -- Hide filename extension when set to true.
	show_modified_status = true, -- Shows indicator when the buffer is modified.

	mode = 0, -- 0: Shows buffer name
	-- 1: Shows buffer index
	-- 2: Shows buffer name + buffer index
	-- 3: Shows buffer number
	-- 4: Shows buffer name + buffer number

	max_length = vim.o.columns * 2 / 3, -- Maximum width of buffers component,
	-- it can also be a function that returns
	-- the value of `max_length` dynamically.
	filetype_names = {
		TelescopePrompt = "Telescope",
		dashboard = "Dashboard",
		packer = "Packer",
		fzf = "FZF",
		alpha = "Alpha",
		NvimTree_1 = "NvimTree",
	}, -- Shows specific buffer name for that filetype ( { `filetype` = `buffer_name`, ... } )

	buffers_color = {
		-- Same values as the general color option can be used here.
		active = "lualine_{section}_normal", -- Color for active buffer.
		inactive = "lualine_{section}_inactive", -- Color for inactive buffer.
	},

	symbols = {
		modified = " ●", -- Text to show when the buffer is modified
		alternate_file = "#", -- Text to show to identify the alternate file
		directory = "", -- Text to show when the buffer is a directory
	},
}

local tabs = {
	"tabs",
	max_length = vim.o.columns / 3, -- Maximum width of tabs component.
	-- Note:
	-- It can also be a function that returns
	-- the value of `max_length` dynamically.
	mode = 1, -- 0: Shows tab_nr
	-- 1: Shows tab_name
	-- 2: Shows tab_nr + tab_name

	tabs_color = {
		-- Same values as the general color option can be used here.
		active = "lualine_{section}_normal", -- Color for active tab.
		inactive = "lualine_{section}_inactive", -- Color for inactive tab.
	},
}
local custom_auto_theme = require("lualine.themes.auto")
custom_auto_theme.normal.c.bg = dark_gray
local navic = require("nvim-navic")
lualine.setup({
	options = {
		theme = custom_auto_theme,
		globalstatus = true,
		icons_enabled = true,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { mode, left_sep, branch, diff, right_sep, left_sep, filename, filesize, right_sep },
		lualine_x = {
			lanuage_server,
			spaces,
			left_sep,
			diagnostics,
			right_sep,
			filetype,
			left_sep,
			location,
			right_sep,
		},
		lualine_y = {},
		lualine_z = {},
	},

	extensions = { "nvim-tree", "toggleterm" },
})
