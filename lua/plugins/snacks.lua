return {
	"folke/snacks.nvim",
	lazy = false,

	--- @module "snacks"
	--- @type snacks.Config
	opts = {

		scroll = {
			enabled = true,
			animate = {
				enabled = true,
			},
		},

		indent = {
			enabled = true,
			animate = {
				-- too distracting :)
				enabled = false,
			},
		},

		picker = {
			enabled = true,
			layout = {
				preset = function()
					return vim.o.columns >= 100 and "default" or "vertical"
				end,
			},
		},

		explorer = {
			enabled = true,
			follow_file = true,
		},

		terminal = {
			enabled = true,
		},

		image = {
			enabled = true,
		},

	},

	keys = {
		{
			"<leader>sp",
			function()
				Snacks.picker.files()
			end,
			desc = "lua Snacks.picker.files()"
		},
		{
			"<leader>st",
			function()
				Snacks.terminal.open()
			end,
			desc = "lua Snacks.terminal.open()"
		},
		{
			"<leader>se",
			function()
				Snacks.explorer.open()
			end,
			desc = "lua Snacks.explorer.open()"
		},
	},

	init = function()

		vim.api.nvim_set_hl(0, "SnacksIndentScope", {
			link = "GruvBoxBg4",
		})
		vim.api.nvim_set_hl(0, "SnacksIndent", {
			link = "GruvBoxBg1",
		})

		-- Quit nvim when explorer is last open window
		-- https://github.com/folke/snacks.nvim/discussions/1346
		vim.api.nvim_create_autocmd('QuitPre', {
			callback = function()
				local snacks_windows = {}
				local floating_windows = {}
				local windows = vim.api.nvim_list_wins()
				for _, w in ipairs(windows) do
					local filetype = vim.api.nvim_get_option_value('filetype', { buf = vim.api.nvim_win_get_buf(w) })
					if filetype:match('snacks_') ~= nil then
						table.insert(snacks_windows, w)
					elseif vim.api.nvim_win_get_config(w).relative ~= '' then
						table.insert(floating_windows, w)
					end
				end
				if 1 == #windows - #floating_windows - #snacks_windows then
					-- Should quit, so we close all Snacks windows.
					for _, w in ipairs(snacks_windows) do
						vim.api.nvim_win_close(w, true)
					end
				end
			end,
		})

	end

}
