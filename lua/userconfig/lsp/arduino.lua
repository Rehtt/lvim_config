if vim.fn.expand("arduino_language_server") == "" then
  vim.notify("arduino_language_server not installed", vim.log.levels.WARN)
  vim.notify("Please install arduino-language-server", vim.log.levels.WARN)
  return
end

if vim.fn.expand("clangd") == "" then
  vim.notify("clangd not installed", vim.log.levels.WARN)
  vim.notify("Please install clangd", vim.log.levels.WARN)
  return
end


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
    "arduino-language-server",                                         -- mason 安装的 arduino-language-server
    -- "-clangd", vim.fn.exepath("clangd"),                               -- 指定 clangd
    "-cli", vim.fn.exepath("arduino-cli"),                             -- 自行安装arduino-cli
    "-cli-config", vim.fn.expand("$HOME/.arduino15/arduino-cli.yaml"), -- 自行配置
  },
  filetypes = { "arduino", "ino" },
  root_dir = function(fname)
    -- 先找 sketch.yaml / .git 作项目根，否则用当前文件夹
    local util = require("lspconfig.util")
    return util.root_pattern("sketch.yaml", ".git")(fname) or util.path.dirname(fname)
  end,

  on_new_config = function(new_cfg, root_dir)
    local fqbn = find_fqbn(root_dir) or "arduino:avr:uno"

    new_cfg.cmd = vim.deepcopy(new_cfg.cmd)
    table.insert(new_cfg.cmd, "--fqbn=" .. fqbn)

    vim.notify("[arduino-ls] Using FQBN: " .. fqbn, vim.log.levels.DEBUG)
  end,
})
