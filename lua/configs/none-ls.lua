local map = require("helpers").keymapper

return function ()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				-- Lua
				null_ls.builtins.formatting.stylua,

				-- Nix
				null_ls.builtins.formatting.alejandra,
				null_ls.builtins.code_actions.statix,
				null_ls.builtins.diagnostics.statix,
			},
		})

    -- Setup mappings
		map("n", "<leader>lf", vim.lsp.buf.format, { desc = "LSP: [F]ormat Document" })
end
