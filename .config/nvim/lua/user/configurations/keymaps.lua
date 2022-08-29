local generic_opts_any = { noremap = true, silent = true }

local generic_opts = {
	insert_mode = generic_opts_any,
	normal_mode = generic_opts_any,
	visual_mode = generic_opts_any,
	visual_block_mode = generic_opts_any,
	command_mode = generic_opts_any,
	term_mode = { silent = true },
}

local mode_adapters = {
	insert_mode = "i",
	normal_mode = "n",
	term_mode = "t",
	visual_mode = "v",
	visual_block_mode = "x",
	command_mode = "c",
}
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", generic_opts_any)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local defaults = {
	---@usage change or add keymappings for normal mode
	normal_mode = {
		-- Better window movement
		["<A-h>"] = "<C-w>h",
		["<A-j>"] = "<C-w>j",
		["<A-k>"] = "<C-w>k",
		["<A-l>"] = "<C-w>l",

		-- Resize with arrows
		["<A-w>"] = ":resize -2<CR>",
		["<A-s>"] = ":resize +2<CR>",
		["<A-a>"] = ":vertical resize -2<CR>",
		["<A-d>"] = ":vertical resize +2<CR>",
		["<C-Space>"] = "<C-\\><C-N>:ToggleTerm<cr>",
	},

	---@usage change or add keymappings for insert mode
	insert_mode = {
		-- 'jk'/'jj'/'kj' for quitting insert mode
		["jk"] = "<ESC>",
		["kj"] = "<ESC>",
		["jj"] = "<ESC>",
		-- Move current line with Alt-j/k ala vscode.
		["<A-j>"] = "<Esc>:m .+1<CR>==gi",
		-- Move current line with Alt-j/k ala vscode.
		["<A-k>"] = "<Esc>:m .-2<CR>==gi",
	},

	---@usage change or add keymappings for terminal mode
	term_mode = {
		-- Terminal window navigation
		["<C-Space>"] = "<C-\\><C-N>:ToggleTerm<cr>",
	},

	---@usage change or add keymappings for visual mode
	visual_mode = {
		-- Better indenting
		["<"] = "<gv",
		[">"] = ">gv",
	},

	---@usage change or add keymappings for visual block mode
	visual_block_mode = {
		-- Move current block with Alt-j/k ala vscode.
		["<A-j>"] = ":m '>+1<CR>gv-gv",
		["<A-k>"] = ":m '<-2<CR>gv-gv",
	},

	---@usage change or add keymappings for command mode
	command_mode = {
		-- navigate tab completion with <c-j> and <c-k>
		-- runs conditionally
		["<C-j>"] = { 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true } },
		["<C-k>"] = { 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true } },
	},
}

-- Set key mappings individually
-- @param mode The keymap mode, can be one of the keys of mode_adapters
-- @param key The key of keymap
-- @param val Can be form as a mapping or tuple of mapping and user defined opt
local set_keymaps = function(mode, key, val)
	local opt = generic_opts[mode] or generic_opts_any
	if type(val) == "table" then
		opt = val[2]
		val = val[1]
	end
	if val then
		vim.api.nvim_set_keymap(mode, key, val, opt)
	else
		pcall(vim.api.nvim_del_keymap, mode, key)
	end
end

-- Load key mappings for a given mode
-- @param mode The keymap mode, can be one of the keys of mode_adapters
-- @param keymaps The list of key mappings
local function load_mode(mode, keymaps)
	mode = mode_adapters[mode] or mode
	for k, v in pairs(keymaps) do
		set_keymaps(mode, k, v)
	end
end

-- Load key mappings for all provided modes
-- @param keymaps A list of key mappings for each mode
local function load(keymaps)
	keymaps = keymaps or {}
	for mode, mapping in pairs(keymaps) do
		load_mode(mode, mapping)
	end
end

-- Load the default keymappings
load(defaults)
