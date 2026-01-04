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


-- quickly check diagnostics
vim.keymap.set('n', '<leader>do', ':lua vim.diagnostic.open_float()<CR>')


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

-- open a terminal in a new tab
--vim.keymap.set('n', '<leader>tt', function()
--	vim.api.nvim_exec2(
--		':tab term\n' ..
--		':set nonumber\n' ..
--		':set norelativenumber\n' ..
--		':set nowrap\n' ..
--		':startinsert'
--	, {})
--end)
