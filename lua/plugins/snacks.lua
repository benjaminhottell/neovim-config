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
	end

}
