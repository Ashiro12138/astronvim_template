-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEFORE ENABLING THIS FILE
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
    "kevinhwang91/nvim-bqf",
    event = "VeryLazy",
  },
  {
    "junegunn/fzf",
    event = "VeryLazy",
    build = "./install --all",
  },
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
    config = function() vim.g.VM_theme = "codedark" end,
    -- Basic usage:
    --
    --     select words with Ctrl-N (like Ctrl-d in Sublime Text/VS Code)
    --     create cursors vertically with Ctrl-Down/Ctrl-Up
    --     select one character at a time with Shift-Arrows
    --     press n/N to get next/previous occurrence
    --     press [/] to select next/previous cursor
    --     press q to skip current and get next occurrence
    --     press Q to remove current cursor/selection
    --     start insert mode with i,a,I,A
  },
  {
    "rhysd/conflict-marker.vim",
    event = "VeryLazy",
    -- `[x` and `]x` to jump among conflict markers
    -- `ct` to choose theirs
    -- `co` to choose ours
    -- `cn` to choose none
    -- `cb` to choose both
  },
  {
    "terryma/vim-expand-region",
    event = "VeryLazy",
    -- '+' to expand visual select region,
    -- '_' to shrink visual select region,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },
}
