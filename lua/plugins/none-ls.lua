-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, config)
    -- config variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics

    null_ls.setup {
      sources = {
        require "none-ls.diagnostics.eslint_d",
        require "none-ls.code_actions.eslint_d",
        require "none-ls.formatting.eslint_d",
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
      },
    }

    return config -- return final config table
  end,
}
