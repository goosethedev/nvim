return function()
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
end
