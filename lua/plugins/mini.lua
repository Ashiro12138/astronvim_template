---@type LazySpec
return {
  {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    version = "*",
    config = function()
      require("mini.move").setup(
        -- If this is not working in terminal, use the following escape character mapping
        --
        -- <M-h>: 0x1B 0x68
        -- <M-j>: 0x1B 0x6A
        -- <M-k>: 0x1B 0x6B
        -- <M-l>: 0x1B 0x6C
        --
        -- Note: 0x1B is the escape character and 0x6* is the actual key itself
      )
      require("mini.cursorword").setup()
    end,
  },
}
