local map = require("helpers").keymapper

return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup()

		-- Set custom terminals with keybinds
		local Terminal = require("toggleterm.terminal").Terminal
		local new_term = function(cmd)
			return Terminal:new({ cmd = cmd, hidden = false, direction = "float", name = cmd })
		end

		local gitui = new_term("gitui")
		local yazi = new_term("yazi")
		local btm = new_term("btm")

		function _gitui_toggle()
			gitui:toggle()
		end
		function _yazi_toggle()
			yazi:toggle()
		end
		function _btm_toggle()
			btm:toggle()
		end

		map("n", "<leader>tg", "<cmd>lua _gitui_toggle()<CR>", { desc = "Open GitUI" })
		map("n", "<leader>ty", "<cmd>lua _yazi_toggle()<CR>", { desc = "Open yazi" })
		map("n", "<leader>tb", "<cmd>lua _btm_toggle()<CR>", { desc = "Open btm" })
	end,
}
