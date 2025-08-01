-- Customize Mason

---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        -- install language servers
        "lua-language-server",
        "typescript-language-server",

        -- install formatters
        "stylua",
        "prettier",
        "stylua",
        "eslint_d",

        -- install debuggers
        "debugpy",
        "node-debug2-adapter",

        -- install any other package
        "tree-sitter-cli",
      },
    },
  },
}
