return {
	{
		"NeogitOrg/neogit",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"folke/snacks.nvim",
		},
		cmd = {
			"Neogit",
		},
		keys = {
			{
				"<leader>gg",
				"<cmd>Neogit<cr>",
				desc = "(neogit) Show Neogit UI",
			}
		},
	}
}
