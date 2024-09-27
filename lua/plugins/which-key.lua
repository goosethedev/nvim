-- Show available mappings
return {
	"folke/which-key.nvim",
	event = "VimEnter",
	opts = {
		spec = {
			{ ",", group = "Prev f/t char search" },
			{ ";", group = "Next f/t char search" },
			{ "<leader>d", group = "[D]iagnostics" },
			{ "<leader>f", group = "[F]ile" },
			{ "<leader>g", group = "[G]it" },
			{ "<leader>l", group = "[L]SP" },
			{ "<leader>p", group = "[P]ersistence" },
			{ "<leader>s", group = "[S]earch" },
			{ "<leader>sg", group = "[S]earch [G]it" },
			{ "<leader>t", group = "[T]erminal" },
			{ "<leader>w", group = "[W]indow" },
			{ "<leader>x", group = "[X]tra / E[X]it" },
			{ "<leader>xi", group = "Config [I]nfo" },
		},
	},
}
