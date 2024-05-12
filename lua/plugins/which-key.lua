-- Show available mappings
return {
	"folke/which-key.nvim",
	event = "VimEnter",
	config = function()
		require("which-key").setup()

		-- Document existing key chains
		require("which-key").register({
			["g"] = { name = "+goto" },
			["gs"] = { name = "+surround" },
			["z"] = { name = "+fold" },
			["]"] = { name = "+next" },
			["["] = { name = "+prev" },
			["u"] = { name = "Undo last action" },
			[";"] = { name = "Next f/t char search" },
			[","] = { name = "Prev f/t char search" },
			["<leader>d"] = { name = "[D]iagnostics", _ = "which_key_ignore" },
			["<leader>f"] = { name = "[F]ile", _ = "which_key_ignore" },
			["<leader>g"] = { name = "[G]ile", _ = "which_key_ignore" },
			["<leader>l"] = { name = "[L]SP", _ = "which_key_ignore" },
			["<leader>p"] = { name = "[P]ersistence", _ = "which_key_ignore" },
			["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
			["<leader>sg"] = { name = "[S]earch [G]it", _ = "which_key_ignore" },
			["<leader>w"] = { name = "[W]indow", _ = "which_key_ignore" },
			["<leader>x"] = { name = "[X]tra / E[X]it", _ = "which_key_ignore" },
			["<leader>xi"] = { name = "Config [I]nfo", _ = "which_key_ignore" },
		})
	end,
}
