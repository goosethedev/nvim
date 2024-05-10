return {
  -- Detect tabstop and shiftwidth automatically
  -- "tpope/vim-sleuth",

  -- "gc" to comment visual regions/lines
  { "numToStr/Comment.nvim", opts = {} },

  {
    -- Cmd tools as unified LSP
    "nvimtools/none-ls.nvim",
    config = require("configs.none-ls"),
  },
}
