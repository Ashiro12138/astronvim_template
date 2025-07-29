-- Customize alpha options

---@type LazySpec
return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    local lines
    local fortune_exists = vim.fn.executable "fortune" == 1
    local cowsay_exists = vim.fn.executable "cowsay" == 1

    if fortune_exists and cowsay_exists then
      -- Get the output of the bash command 'fortune | cowsay'
      local handle = io.popen "fortune | cowsay"
      if handle then
        local result = handle:read "*a"
        handle:close()

        -- Split the result by new lines
        lines = {}
        for s in result:gmatch "[^\r\n]+" do
          table.insert(lines, s)
        end
      end
    end

    opts.dashboard = opts.dasboard or {}
    opts.dashboard.preset = opts.dashboard.preset or {}

    -- Only override the header if `fortune | cowsay` succeeded
    if lines and #lines > 0 then
      opts.dashboard.preset.header = table.concat(lines, "\n")
    else
      -- Keep the default hardcoded header
      opts.dashboard.preset.header = table.concat {
        " █████  ███████ ████████ ██████   ██████ ",
        "██   ██ ██         ██    ██   ██ ██    ██",
        "███████ ███████    ██    ██████  ██    ██",
        "██   ██      ██    ██    ██   ██ ██    ██",
        "██   ██ ███████    ██    ██   ██  ██████ ",
        "",
        "███    ██ ██    ██ ██ ███    ███",
        "████   ██ ██    ██ ██ ████  ████",
        "██ ██  ██ ██    ██ ██ ██ ████ ██",
        "██  ██ ██  ██  ██  ██ ██  ██  ██",
        "██   ████   ████   ██ ██      ██",
      }
    end

    return opts
  end,
}
