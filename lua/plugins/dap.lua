local icons = {
  Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
  Breakpoint = " ",
  BreakpointCondition = " ",
  BreakpointRejected = { " ", "DiagnosticError" },
  LogPoint = ".>",
}
local javascript_file_types = { "typescript", "javascript", "javascriptreact", "typescriptreact" }
local vscode_type_to_ft

---@type LazySpec
return {
  "mfussenegger/nvim-dap",

  dependencies = {
    "rcarriga/nvim-dap-ui",

    {
      "microsoft/vscode-js-debug",
      build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
    },
  },

  keys = {
    {
      "<leader>da",
      function()
        ---Load most recent `.vscode/launch.json` config
        ---https://github.com/mfussenegger/nvim-dap/issues/20#issuecomment-1356791734
        require("dap.ext.vscode").load_launchjs(nil, vscode_type_to_ft)
        require("dap").continue()
      end,
      desc = "Start/Continue (F5)",
    },
    {
      "<leader>dc",
      function() require("dap").run_to_cursor() end,
      desc = "Run To Cursor",
    },
    {
      "<leader>db",
      function() require("dap").toggle_breakpoint() end,
      desc = "Debug: Toggle Breakpoint",
    },
    {
      "<leader>di",
      function() require("dap").step_into() end,
      desc = "Debug: Step Into",
    },
    {
      "<leader>do",
      function() require("dap").step_over() end,
      desc = "Debug: Step Over",
    },
    {
      "<leader>dO",
      function() require("dap").step_out() end,
      desc = "Debug: Step Out",
    },
    {
      "<leader>dt",
      function() require("dap").terminate() end,
      desc = "Debug: Terminate",
    },
    {
      "<leader>dB",
      function() require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ") end,
      desc = "Debug: Set Breakpoint",
    },
  },

  config = function()
    local dap = require "dap"
    local dapui = require "dapui"
    local mason_registry = require "mason-registry"

    -- Custom icons for DAP (breakpoints etc.)
    for name, sign in pairs(icons) do
      sign = type(sign) == "table" and sign or { sign }
      vim.fn.sign_define(
        "Dap" .. name,
        { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
      )
    end

    vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
      controls = {
        icons = {
          pause = "⏸",
          play = "▶",
          step_into = "⏎",
          step_over = "⏭",
          step_out = "⏮",
          step_back = "b",
          run_last = "▶▶",
          terminate = "⏹",
          disconnect = "⏏",
        },
      },
    }

    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close

    ---╔══════════════════════════════════════╗
    ---║               Adapters               ║
    ---╚══════════════════════════════════════╝

    local vscode_js_debug_dap = mason_registry.get_package "js-debug-adapter"

    if vscode_js_debug_dap then
      local dap_executable = vscode_js_debug_dap:get_install_path() .. "/js-debug/src/dapDebugServer.js"

      for _, type in ipairs {
        "node",
        "chrome",
        "pwa-node",
        "pwa-chrome",
        "pwa-msedge",
        "node-terminal",
        "pwa-extensionHost",
      } do
        local host = "localhost"
        dap.adapters[type] = {
          type = "server",
          host = host,
          port = "${port}",
          executable = {
            command = "node",
            args = { dap_executable, "${port}", host },
          },
        }
      end
    end

    ---╔══════════════════════════════════════╗
    ---║           Configurations             ║
    ---╚══════════════════════════════════════╝

    local function url_prompt(default)
      default = default or "http://localhost:3000"
      local co = coroutine.running()
      return coroutine.create(function()
        vim.ui.input({ prompt = "Enter URL: ", default = default }, function(url)
          if url == nil or url == "" then
            return
          else
            coroutine.resume(co, url)
          end
        end)
      end)
    end

    for _, language in ipairs(javascript_file_types) do
      dap.configurations[language] = {
        {
          name = "DAP: Debug with PWA Chrome",
          type = "pwa-chrome",
          request = "launch",
          sourceMaps = true,
          url = url_prompt,
          ---These 2 options are important for nextjs apps
          webRoot = vim.fn.getcwd(),
          userDataDir = false,
        },
        ---While vscode supports typescript files as entrypoints to your debugger
        ---`nvim-dap-vscode-js` needs a loader like `ts-node`. A different approach
        ---could be using `vscode-node-debug2` but it is deprecated.
        {
          name = "DAP: Debug with Node (ts-node)",
          type = "pwa-node",
          request = "launch",
          cwd = "${workspaceFolder}",
          runtimeExecutable = "node",
          runtimeArgs = { "--loader", "ts-node/esm" },
          args = { "${file}" },
          sourceMaps = true,
          protocol = "inspector",
          skipFiles = { "<node_internals>/**", "node_modules/**" },
        },
        {
          name = "DAP: Attach",
          type = "pwa-node",
          request = "attach",
          port = 9229,
        },
      }
    end

    -- This gets passed to require('dap.ext.vscode').load_launchjs when debugging starts.
    vscode_type_to_ft = {
      ["node"] = javascript_file_types.javascript_filetypes,
      ["chrome"] = javascript_file_types.javascript_filetypes,
      ["firefox"] = javascript_file_types.javascript_filetypes,
      ["pwa-node"] = javascript_file_types.javascript_filetypes,
      ["pwa-chrome"] = javascript_file_types.javascript_filetypes,
      ["pwa-msedge"] = javascript_file_types.javascript_filetypes,
      ["node-terminal"] = javascript_file_types.javascript_filetypes,
      ["pwa-extensionHost"] = javascript_file_types.javascript_filetypes,
    }
  end,
}
