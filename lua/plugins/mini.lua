---@type LazySpec
return {
  {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    version = "*",
    config = function()
      require("mini.move").setup()
      require("mini.cursorword").setup()
    end,
  },
}
