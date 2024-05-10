local M = {}

-- Function to create keymaps
M.keymapper = function(mode, l, r, opts)
	opts = opts or {}
	vim.keymap.set(mode, l, r, vim.tbl_extend("force", { silent = true }, opts))
end

return M
