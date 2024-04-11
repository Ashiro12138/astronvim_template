-- For running jest tests

---@type LazySpec
return {
  "nvim-neotest/neotest",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "mfussenegger/nvim-dap",

    -- Adapters
    "nvim-neotest/neotest-jest",
  },

  keys = {
    {
      "<leader>tr",
      '<cmd>lua require("neotest").run.run()<CR>',
      desc = "Run test",
    },
    {
      "<leader>ts",
      '<cmd>lua require("neotest").summary.toggle()<CR>',
      desc = "Toggle test summary",
    },
    {
      "<leader>to",
      '<cmd>lua require("neotest").output_panel.toggle()<CR>',
      desc = "Toggle test output panel",
    },
    {
      "<leader>tO",
      '<cmd>lua require("neotest").output.open()<CR>',
      desc = "Open test output",
    },
    {
      "<leader>td",
      '<cmd>lua require("neotest").run.run({strategy = "dap"})<CR>',
      desc = "Debug test",
    },
  },

  config = function()
    require("neotest").setup {
      discovery = {
        enabled = false,
      },

      adapters = {
        require "neotest-jest" {
          jestCommand = "npx jest",
          jestConfigFile = "jest.config.js",
          -- env = { CI = true },
          cwd = function() return vim.fn.getcwd() end,
        },
      },
    }
  end,
}
