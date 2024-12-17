-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

require('userconfig.plugin')

require('userconfig.cmp')

require('userconfig.format')

require('userconfig.keymapping')

require('userconfig.osc52')

require('userconfig.dap.go')

-- lvim.transparent_window = true

lvim.builtin.gitsigns.opts.current_line_blame = true

-- 自定义logo
-- lvim.builtin.alpha.dashboard.section.header.val = {}

-- 切换gopls的build tags
-- :lua SetGoBuildTags("tag")
function SetGoBuildTags(tags)
  local lspconfig = require 'lspconfig'
  lspconfig.gopls.setup {
    settings = {
      gopls = {
        buildFlags = { "-tags=" .. tags }
      }
    }
  }
  -- 手动重新启动 LSP 客户端
  vim.cmd('LspRestart')
end
