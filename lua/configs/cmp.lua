return function()
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
		mapping = cmp.mapping.preset.insert({
			["<PageUp>"] = cmp.mapping.scroll_docs(-4),
			["<PageDown>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<Left>"] = cmp.mapping.abort(),
			-- CMP offers recommendations for every erased character. nuh-uh
			-- ["<BS>"] = cmp.mapping.abort(),
			-- Makes me press Esc twice very often. nuh-uh
			-- ["<Esc>"] = cmp.mapping.abort(),
			["<Right>"] = cmp.mapping.confirm({ select = true }),
			["<CR>"] = cmp.mapping.confirm({ select = true }),
		}),
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
