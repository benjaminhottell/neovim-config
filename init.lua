-- Neovim configuration
-- https://neovim.io/doc/user/lua.html

-- leader key for custom commands
vim.g.mapleader = " " -- spacebar

-- tab width
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- enables mouse interaction
vim.opt.mouse = 'a'

-- update terminal window title
vim.opt.title = true

-- hide welcome screen
vim.opt.shortmess:append({ I = true })

-- use system clipboard
vim.opt.clipboard = 'unnamedplus'

-- break lines better
vim.opt.wrap = true
vim.opt.linebreak = true

-- indent broken lines
vim.opt.breakindent = true
vim.opt.showbreak='    ' -- 4 spaces

-- enable line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- enable highlighting the current line number differently
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'both'

-- 24-bit ("truecolor")
-- See also :h xterm-true-color
vim.opt.termguicolors = true

-- enable status line
vim.opt.laststatus=2

-- disable netrw (built in file explorer)
-- later a plugin will replace its functionality
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- hide distracting formatting/syntax
-- vim.opt.conceallevel = 2


vim.api.nvim_create_user_command(
	"WordCount",
	function(opts)

		local c = nil

		if opts.range > 0 then
			vim.cmd("normal! gv")
			c = vim.fn.wordcount()
			vim.cmd("normal! \27")
		else
			c = vim.fn.wordcount()
		end

		if c.visual_words ~= nil then
			local msg = string.format(
				"(Visual) %d words, %d chars, %d bytes",
				c.visual_words,
				c.visual_chars,
				c.visual_bytes
			)
			print(msg)
		end

		local msg = string.format(
			"(Global) %d words, %d chars, %d bytes",
			c.words,
			c.chars,
			c.bytes
		)
		print(msg)
	end,
	{
		desc = "Count words in buffer or selection",
		range = true,
	}
)

local function show_diagnostics()
	vim.diagnostic.open_float(nil, {
		scope = "cursor",
		focusable = false,
		border = "rounded",
		close_events = {
			"CursorMoved",
			"CursorMovedI",
		},
	})
end

vim.api.nvim_create_user_command(
	"ShowDiagnostics",
	show_diagnostics,
	{
		desc = "Show diagnostics in a float",
	}
)

-- Snacks.scroll could take up to 200ms
local animation_delay_ms = 200

vim.keymap.set(
	"n",
	"]d",
	function()
		local diagnostic = vim.diagnostic.jump({
			count = 1,
		})
		if diagnostic ~= nil then
			vim.defer_fn(show_diagnostics, animation_delay_ms)
		end
	end,
	{
		noremap = true,
		silent = true,
		desc = "Jump to next diagnostic",
	}
)

vim.keymap.set(
	"n",
	"[d",
	function()
		local diagnostic = vim.diagnostic.jump({
			count = -1,
		})
		if diagnostic ~= nil then
			vim.defer_fn(show_diagnostics, animation_delay_ms)
		end
	end,
	{
		noremap = true,
		silent = true,
		desc = "Jump to previous diagnostic",
	}
)

-- Bootstrapping lazy
-- https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Automatically loads: ~/.config/nvim/lua/plugins/*.lua
	import = "plugins",
})
