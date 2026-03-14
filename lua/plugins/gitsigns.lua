return {
	{
		"lewis6991/gitsigns.nvim",
		event = {
			"VeryLazy",
		},
		cmd = {
			"Gitsigns",
		},
		opts = {
		},

		keys = {
			{
				"]c",
				function()
					if vim.wo.diff then
						vim.cmd.normal({"]c", bang = true})
					else
						local gitsigns = require("gitsigns")
						gitsigns.nav_hunk("next")
					end
				end,
				desc = "(gitsigns) navigate to next chunk",
			},
			{
				"[c",
				function()
					if vim.wo.diff then
						vim.cmd.normal({"[c", bang = true})
					else
						local gitsigns = require("gitsigns")
						gitsigns.nav_hunk("prev")
					end
				end,
				desc = "(gitsigns) navigate to next chunk",
			},
		},

	},
}
