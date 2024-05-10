return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {"lua", "javascript", "rust", "nix", "yaml", "python", "typescript", "tsx", "toml"},
    highlight = { enable = true },
    indent = { enable = true },
  }
}
