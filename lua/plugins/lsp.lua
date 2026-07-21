return {

	{
		"folke/lazydev.nvim",
		ft = "lua",
		cmd = "LazyDev",
		--- @module "lazydev"
		--- @type lazydev.Config
		opts = {
			library = {
				{
					path = "${3rd}/luv/library",
					words = { "vim%.uv" }
				},
			},
		}
	},

	{
		"saghen/blink.cmp",
		version = "1.*",
		event = "VimEnter",
		dependencies = {
			"folke/lazydev.nvim",
		},
		--- @module "blink.cmp"
		--- @type blink.cmp.Config
		opts = {
			keymap = {
				preset = "super-tab",
			},
			completion = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 500,
				},
			},
			sources = {
				default = {
					"lsp",
					"path",
					--"snippets",
					"buffer",
					"lazydev",
				},
				providers = {
					lazydev = {
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
				},
			},
			fuzzy = {
				implementation = "lua",
			},
			signature = {
				enabled = true,
			},
		},
	},

	{
		"neovim/nvim-lspconfig",

		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"mason-org/mason-lspconfig.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			"saghen/blink.cmp",
			"folke/lazydev.nvim",
		},

		cmd = {
			"LspInfo",
			"LspLog",
			"LspRestart",
			"LspStart",
			"LspStop",
		},

		ft = {
			"lua",
			"python",
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
		},

		config = function()

			local capabilities = require("blink.cmp").get_lsp_capabilities()

			--- @param name string
			--- @param config? vim.lsp.Config
			local function add_lsp(name, config)
				if config == nil then
					config = {}
				end
				config.capabilities = capabilities
				vim.lsp.config(name, config)
				vim.lsp.enable(name, true)
			end

			add_lsp("lua_ls")

			add_lsp("pyright", {
				cmd_env = {
					VIRTUAL_ENV = os.getenv("VIRTUAL_ENV"),
					PATH = os.getenv("PATH"),
				},
				settings = {
					python = {
						pythonPath = vim.fn.exepath("python3"),
					},
				},
			})

			add_lsp("vtsls")

		end
	},

	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},

}
