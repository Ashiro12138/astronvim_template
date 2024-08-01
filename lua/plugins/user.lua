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
    "pocco81/true-zen.nvim",
    event = "VeryLazy",
    config = function()
      require("true-zen").setup {
        -- your config goes here
        -- or just leave it empty :)
      }
      local api = vim.api

      api.nvim_set_keymap("n", "<leader>zn", ":TZNarrow<CR>", { desc = "TZ Narrow" })
      api.nvim_set_keymap("v", "<leader>zn", ":'<,'>TZNarrow<CR>", { desc = "TZ Narrow" })
      api.nvim_set_keymap("n", "<leader>zf", ":TZFocus<CR>", { desc = "TZ Focus" })
      api.nvim_set_keymap("n", "<leader>zm", ":TZMinimalist<CR>", { desc = "TZ Minimalist" })
      api.nvim_set_keymap("n", "<leader>za", ":TZAtaraxis<CR>", { desc = "TZ Ataraxis" })
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
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
}
