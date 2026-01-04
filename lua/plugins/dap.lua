return {
	{
		"theHamsta/nvim-dap-virtual-text",
		dependencies = {
			"nvim-treesitter/nvim-treesitter"
		},
		lazy = true,
		opts = {},
	},
	{
		"mfussenegger/nvim-dap",

		dependencies = {
			"theHamsta/nvim-dap-virtual-text",
		},

		lazy = true,

		cmd = {
			"DapClearBreakpoints",
			"DapContinue",
			"DapDisconnect",
			"DapEval",
			"DapNew",
			"DapPause",
			"DapRestartFrame",
			"DapSetLogLevel",
			"DapShowLog",
			"DapStepInto",
			"DapStepOut",
			"DapStepOver",
			"DapTerminate",
			"DapToggleBreakpoint",
			"DapToggleRepl",
		},

		keys = {
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "(nvim-dap) Toggle breakpoint",
			},
			{
				"<leader>dB",
				function()
					require("dap").clear_breakpoints()
				end,
				desc = "(nvim-dap) Clear breakpoints",
			},
			{
				"<leader>dj",
				function()
					require("dap").down()
				end,
				desc = "(nvim-dap) Down",
			},
			{
				"<leader>dk",
				function()
					require("dap").up()
				end,
				desc = "(nvim-dap) Up",
			},
			{
				"<leader>dr",
				function()
					require("dap").continue()
				end,
				desc = "(nvim-dap) Run or continue",
			},
			{
				"<leader>di",
				function()
					require("dap").step_into()
				end,
				desc = "(nvim-dap) Step into",
			},
			{
				"<leader>do",
				function()
					require("dap").step_over()
				end,
				desc = "(nvim-dap) Step over",
			},
			{
				"<leader>dO",
				function()
					require("dap").step_out()
				end,
				desc = "(nvim-dap) Step out",
			},
			{
				"<leader>dq",
				function()
					require("dap").terminate()
				end,
				desc = "(nvim-dap) Terminate",
			},
		},

		config = function()
		end,

	},

	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"mfussenegger/nvim-dap",
		},
		lazy = true,
		opts = {},
		keys = {
			{
				"<leader>du",
				function()
					require("dapui").toggle()
				end,
				desc = "(nvim-dap-ui) Toggle DAP UI"
			}
		},
	},

}
