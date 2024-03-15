return {
  colorscheme = "catppuccin",

  plugins = {
    {
      "catppuccin/nvim",
      name = "catppuccin",
      config = function()
        require("catppuccin").setup {}
      end,
    },
    {
      "Civitasv/cmake-tools.nvim"
    },
  },
}
