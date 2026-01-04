return {

	{
		"nvim-treesitter/nvim-treesitter",
		cmd = {
			"TSBufDisable",
			"TSBufEnable",
			"TSDisable",
			"TSEnable",
			"TSUninstall",
			"TSUpdate",
			"TSInstall",
		},
		event = {
			"VeryLazy",
		},
		build = ":TSUpdate",
		--- @module "nvim-treesitter"
		opts = {
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			},
			folds = {
				enable = true,
			},
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"javascript",
				"jsdoc",
				"json",
				"jsonc",
				"lua",
				"markdown",
				"markdown_inline",
				"nix",
				"printf",
				"python",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
			},
		},
		config = function(_, opts)
			-- Must manually specify path to `setup`
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

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
			add_lsp("pyright")
		end
	},

}
