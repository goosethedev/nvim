-- Mappings when completions are shown
local mappings_fn = function(mapping)
	return {
		["<PageUp>"] = mapping.scroll_docs(-4),
		["<PageDown>"] = mapping.scroll_docs(4),
		["<C-Space>"] = mapping.complete(),
		["<Left>"] = mapping.abort(),
		["<Right>"] = mapping.confirm({ select = true }),
		["<CR>"] = mapping.confirm({ select = true }),
		-- CMP offers recommendations for every erased character. nuh-uh
		-- ["<BS>"] = mapping.abort(),
		-- Makes me press Esc twice very often. nuh-uh
		-- ["<Esc>"] = mapping.abort(),
	}
end

-- Entire config for plugin
local config_fn = function()
	local cmp = require("cmp")
	-- Load VSCode snippets
	require("luasnip.loaders.from_vscode").lazy_load()

	cmp.setup({
		snippet = {
			-- REQUIRED - snippet engine to use
			expand = function(args)
				require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
			end,
		},
		-- Floating window settings
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		-- Mappings for completion when available
		mapping = cmp.mapping.preset.insert(mappings_fn(cmp.mapping)),

		-- Sources to import for completions
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "luasnip" }, -- For luasnip users.
			{ name = "path" },
		}, {
			-- Load this group if none of the above has options
			-- Info at :h group_index
			{ name = "buffer" },
		}),
	})
end

return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	config = config_fn,
	dependencies = {
		"saadparwaiz1/cmp_luasnip", -- From Luasnip engine
		"hrsh7th/cmp-nvim-lsp", -- From LSP
		"hrsh7th/cmp-path", -- From file paths
		"hrsh7th/cmp-buffer", -- From words in buffer

		{ -- Luasnip snippets engine
			"L3MON4D3/LuaSnip",
			dependencies = "rafamadriz/friendly-snippets",

			build = (function()
				-- Build Step is needed for regex support in snippets.
				-- This step is not supported in many windows environments.
				-- Remove the below condition to re-enable on windows.
				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
					return
				end
				return "make install_jsregexp"
			end)(),
		},

		-- Autopairing of {}[]()
		{
			"windwp/nvim-autopairs",
			opts = {
				fast_wrap = {},
				disable_filetype = { "TelescopePrompt", "vim" },
			},
			config = function(_, opts)
				require("nvim-autopairs").setup(opts)

				-- setup cmp for autopairs
				local cmp_autopairs = require("nvim-autopairs.completion.cmp")
				require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
			end,
		},
	},
}
