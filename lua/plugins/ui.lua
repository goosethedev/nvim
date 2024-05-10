return {
  { -- Best theme ever
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  { -- Dashboard at startup
    "goolord/alpha-nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("alpha").setup(require("alpha.themes.theta").config)
    end,
  },

  { -- File explorer
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    keys = {
      { "<leader>f", ":Neotree filesystem toggle right<CR>", desc = "[F]ile Tree" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window
    },
    opts = {
      close_if_last_window = true
    },
  },

  { -- Status line
    "nvim-lualine/lualine.nvim",
    config = true,
  },

  { -- Show pending keybinds
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function()
      require("which-key").setup()

      -- Document existing key chains
      require("which-key").register({
        ["<leader>l"] = { name = "[L]SP", _ = "which_key_ignore" },
        ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
        ["<leader>w"] = { name = "[W]indow", _ = "which_key_ignore" },
        ["<leader>x"] = { name = "E[X]it", _ = "which_key_ignore" },
      })
    end,
  },
}
