local helper_map = require("helpers").keymapper

return function()
	--  When attaching an LSP to a buffer:
	--  - Set up mappings for LSP functionalities
	--  - Setup highlights on cursor standby
	--  - Set up LSPs with additional capabilities
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
		callback = function(event)
			-- Custom keymapper for LSP
			local map = function(keys, func, desc)
				helper_map("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
			end

			local telescope = require("telescope.builtin")

			-- Jump to the definition (first declared)
			--  To jump back, press <C-t>.
			map("<leader>ld", telescope.lsp_definitions, "Go to [D]efinition")

			-- WARN: This is not Goto Definition, this is Goto Declaration.
			map("<leader>lD", vim.lsp.buf.declaration, "Go to [D]eclaration")

			-- Find references for the word under your cursor.
			map("<leader>lr", telescope.lsp_references, "Go to [R]eferences")

			-- Jump to the implementation
			map("<leader>lI", telescope.lsp_implementations, "Go to [I]mplementation")

			-- Jump to the type's definition of a variable
			map("<leader>lt", telescope.lsp_type_definitions, "Go to [T]ype Definition")

			-- Fuzzy find all the symbols (vars, funcs, types, etc) in your current document
			map("<leader>ls", telescope.lsp_document_symbols, "[S]ymbols in document")

			-- Fuzzy find all the symbols in your current workspace
			map("<leader>lS", telescope.lsp_dynamic_workspace_symbols, "[S]ymbols in project")

			-- Rename the variable under your cursor
			map("<F2>", vim.lsp.buf.rename, "Rename symbol")
			map("<leader>ln", vim.lsp.buf.rename, "Re[N]ame symbol")

			-- Execute a code action for error under the cursor
			map("<leader>lc", vim.lsp.buf.code_action, "[C]ode Action")

			-- Hover docs about the word under your cursor
			map("K", vim.lsp.buf.hover, "Hover Documentation")

			-- Highlight references after updatetime (and unset when cursor is moved)
			local client = vim.lsp.get_client_by_id(event.data.client_id)
			if client and client.server_capabilities.documentHighlightProvider then
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = event.buf,
					callback = vim.lsp.buf.document_highlight,
				})

				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					buffer = event.buf,
					callback = vim.lsp.buf.clear_references,
				})
			end
		end,
	})

	-- Extend default capabilities with LSP for autocompletion
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

	-- List your desired servers with their configs (empty for keeping defaults)
	-- :h lspconfig-all for all preconfigured ones
	-- Available keys:
	--  - cmd (table): Override the default command used to start the server
	--  - filetypes (table): Override the default list of associated filetypes for the server
	--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
	--  - settings (table): Override the default settings passed when initializing the server.
	local servers = {
		lua_ls = {
			settings = {
				Lua = {
					completion = {
						callSnippet = "Replace",
					},
					-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
					-- diagnostics = { disable = { 'missing-fields' } },
				},
			},
		},
		pyright = {},
		rust_analyzer = {},
		tsserver = {},
	}

	-- Install LSP and cmd tools with Mason
	local ensure_installed = vim.tbl_keys(servers or {})
	vim.list_extend(ensure_installed, {
		"stylua", -- Lua code formatting
		-- "alejandra", -- Nix formatting (not available for now)
		-- "statix", -- Nix diagnostics (not available for now)
	})
	require("mason").setup()
	require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

	-- Setup and attach capabilities to servers
	require("mason-lspconfig").setup({
		handlers = {
			function(server_name)
				local server = servers[server_name] or {}
				server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
				require("lspconfig")[server_name].setup(server)
			end,
		},
	})
end
