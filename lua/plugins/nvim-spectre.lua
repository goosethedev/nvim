-- Search / replace in multiple files
return {
	"nvim-pack/nvim-spectre",
	build = false,
	cmd = "Spectre",
	opts = { open_cmd = "noswapfile vnew" },
    -- stylua: ignore
    keys = {
      {
        "<leader>ss",
        function() require("spectre").open() end,
        desc = "[S]pectre: Replace in Files"
      },
    },
}
