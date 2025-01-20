-- Cmd tools as unified LSP
return {
	"nvimtools/none-ls.nvim",
	event = "BufEnter",
	config = function()
		local null_ls = require("null-ls")

		local fmt = null_ls.builtins.formatting
		local ca = null_ls.builtins.code_actions
		local diag = null_ls.builtins.diagnostics

		null_ls.setup({
			sources = {
				-- Fish
				diag.fish,
				fmt.fish_indent,

				-- Lua
				fmt.stylua,

				-- Nix
				fmt.alejandra,
				ca.statix,
				diag.statix,

				-- Rust
				fmt.leptosfmt,

				-- Web
				fmt.prettierd, -- prettier but better?
				-- fmt.prettier,
			},
		})
	end,
}
