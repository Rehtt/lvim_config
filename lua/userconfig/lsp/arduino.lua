local lsp = require("lvim.lsp.manager")

-- 查找 sketch.yaml 中的 fqbn
local function find_fqbn(root)
  local yaml = root .. "/sketch.yaml"
  local fh = io.open(yaml, "r")
  if not fh then return nil end
  for line in fh:lines() do
    local m = line:match("^%s*fqbn:%s*([%w%p]+)")
    if m then
      fh:close()
      return vim.trim(m)
    end
  end
  fh:close()
  return nil
end

-- arduino
lsp.setup("arduino_language_server", {
  cmd = {
    "arduino-language-server", -- mason 安装的 arduino-language-server
  },
  filetypes = { "arduino", "ino" },
  root_dir = function(fname)
    -- 先找 sketch.yaml / .git 作项目根，否则用当前文件夹
    local util = require("lspconfig.util")
    return util.root_pattern("sketch.yaml", ".git")(fname) or util.path.dirname(fname)
  end,

  on_new_config = function(new_cfg, root_dir)
    local conf = {
      -- clangd = "/Applications/Arduino IDE.app/Contents/Resources/app/lib/backend/resources/clangd",           -- 可指定 clangd
      -- arduino_cli = "/Applications/Arduino IDE.app/Contents/Resources/app/lib/backend/resources/arduino-cli", -- 可指定 arduino-cli
      -- cli_config = "",                                                                                        -- 可指定
    }
    if not conf.clangd or conf.clangd == "" then
      conf.clangd = "clangd"
    end
    if not conf.arduino_cli or conf.arduino_cli == "" then
      conf.arduino_cli = "arduino-cli"
    end
    if not conf.cli_config or conf.cli_config == "" then
      conf.cli_config = "~/Library/Arduino15/arduino-cli.yaml"
    end

    if vim.fn.executable("arduino-language-server") == 0 then
      vim.notify("arduino-language-server not found via Mason or PATH", vim.log.levels.WARN)
      return
    end

    if vim.fn.executable(conf.clangd) == 0 then
      vim.notify("Bundled clangd not found", vim.log.levels.WARN)
      return
    end
    if vim.fn.executable(conf.arduino_cli) == 0 then
      vim.notify("Bundled arduino-cli not found", vim.log.levels.WARN)
      return
    end

    local fqbn = find_fqbn(root_dir) or "arduino:avr:uno"

    table.insert(new_cfg.cmd, "-clangd")
    table.insert(new_cfg.cmd, vim.fn.exepath(conf.clangd))

    table.insert(new_cfg.cmd, "-cli")
    table.insert(new_cfg.cmd, vim.fn.exepath(conf.arduino_cli))

    if conf.cli_config ~= "" then
      table.insert(new_cfg.cmd, "-cli-config")
      table.insert(new_cfg.cmd, vim.fn.expand(conf.cli_config))
    end
    table.insert(new_cfg.cmd, "--fqbn=" .. fqbn)

    vim.notify("[arduino-ls] Using FQBN: " .. fqbn, vim.log.levels.DEBUG)
  end,
})
