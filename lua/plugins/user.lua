-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {
  {
    "sitiom/nvim-numbertoggle",
    event = "VeryLazy",
  },
  {
    "tpope/vim-repeat",
    event = "VeryLazy",
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function() require("nvim-surround").setup() end,
  },
  {
    "Wansmer/treesj",
    keys = {
      {
        "<leader>m",
        "<CMD>TSJToggle<CR>",
        desc = "Toggle Treesitter Join",
      },
    },
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
    opts = { use_default_keymaps = false },
    event = "VeryLazy",
  },
  {
    "f-person/git-blame.nvim",
    keys = {
      {
        "<leader>gT",
        "<CMD>GitBlameToggle<CR>",
        desc = "Toggle Git Blame",
      },
    },
    event = "VeryLazy",
    config = function() vim.g.gitblame_date_format = "%r • %x" end,
  },
  {
    "David-Kunz/jester",
    event = "VeryLazy",
  },
  {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    version = false,
    config = function()
      require("mini.move").setup()
      require("mini.cursorword").setup()
    end,
  },
  {
    "kevinhwang91/nvim-bqf",
    event = "VeryLazy",
  },
  {
    "junegunn/fzf",
    event = "VeryLazy",
    dir = "~/.fzf",
    build = "./install --all",
  },
  {
    "mattkubej/jest.nvim",
    event = "VeryLazy",
  },
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
  },
}
