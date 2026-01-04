return {
	{
		"nvim-neotest/neotest",

		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",

			-- Adapters
			"mrcjkb/rustaceanvim",
			"nvim-neotest/neotest-python",
		},

		cmd = {
			"Neotest",
		},

		config = function()
			require("neotest").setup({
				adapters = {
					require("rustaceanvim.neotest"),
					require("neotest-python"),
				},
			})
		end,

		keys = {
			{
				"<leader>ta",
				function()
					require("neotest").run.attach()
				end,
				desc = "(Neotest) Attach to test",
			},
			{
				"<leader>tt",
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
				desc = "(Neotest) Run this file",
			},
			{
				"<leader>tT",
				function()
					require("neotest").run.run(vim.uv.cwd())
				end,
				desc = "(Neotest) Run all files",
			},
			{
				"<leader>tr",
				function()
					require("neotest").run.run()
				end,
				desc = "(Neotest) Run nearest test",
			},
			{
				"<leader>ts",
				function()
					require("neotest").summary.toggle()
				end,
				desc = "(Neotest) Toggle summary",
			},
			{
				"<leader>to",
				function()
					require("neotest").output.open({
						enter = true,
						auto_close = true,
					})
				end,
				desc = "(Neotest) Show output",
			},
			{
				"<leader>tO",
				function()
					require("neotest").output_panel.toggle()
				end,
				desc = "(Neotest) Show output panel",
			},
			{
				"<leader>tq",
				function()
					require("neotest").run.stop()
				end,
				desc = "(Neotest) stop",
			},
			{
				"<leader>tw",
				function()
					require("neotest").watch.toggle()
				end,
				desc = "(Neotest) toggle watch",
			},
		},

	},
}
