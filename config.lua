-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

require('userconfig.plugin')

require('userconfig.cmp')

require('userconfig.format')

require('userconfig.keymapping')

require('userconfig.osc52')

-- dap
require('userconfig.dap.go')

-- lsp
-- 按需开启
-- require('userconfig.lsp.arduino')

-- lvim.transparent_window = true

lvim.builtin.gitsigns.opts.current_line_blame = true

-- enable treesitter integration
lvim.builtin.treesitter.matchup.enable = true

-- 自定义logo
-- lvim.builtin.alpha.dashboard.section.header.val = {}

-- 插入模式下 Ctrl+← 跳到上一个词首并继续插入
vim.keymap.set("i", "<C-Left>", "<Esc>bi", { silent = true })
-- 插入模式下 Ctrl+→ 跳到下一个词尾并继续插入（光标停在词尾后面）
vim.keymap.set("i", "<C-Right>", "<Esc>ea", { silent = true })
