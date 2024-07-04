-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- 插件
lvim.plugins                          = {
  { 'fatih/vim-go' }, -- golang必备

  -- 跳转
  {
    'hadronized/hop.nvim',
    config = function()
      require('hop').setup {}
    end
  },

  -- -- copilot
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   config = function()
  --     require("copilot").setup({})
  --   end,
  -- },
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   config = function()
  --     require("copilot_cmp").setup()
  --   end
  -- },
  -- {
  --   'Exafunction/codeium.vim',
  --   event = 'BufEnter',
  --   config = function()
  --     vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
  --     vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end,
  --       { expr = true, silent = true })
  --     vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
  --       { expr = true, silent = true })
  --     vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
  --   end
  -- },

  -- 代码大纲
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
  },

  -- 高亮多个单词
  {
    'lfv89/vim-interestingwords',
  },

  -- 代码地图，类似vscode缩略图
  {
    'wfxr/minimap.vim',
    build = "cargo install --locked code-minimap",
    -- cmd = {"Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight"},
    config = function()
      vim.cmd("let g:minimap_width = 10")
      vim.cmd("let g:minimap_auto_start = 1")
      vim.cmd("let g:minimap_auto_start_win_enter = 1")
    end,
  },
}
-- vim.g.codeium_disable_bindings = 1

-- 禁用vim-interestingwords默认快捷键
vim.g.interestingWordsDefaultMappings = 0

-- 格式化
lvim.format_on_save.enabled           = true
local formatters                      = require('lvim.lsp.null-ls.formatters')
formatters.setup({
  { name = 'gofumpt',   filetype = { 'go' } },
  { name = 'goimports', filetype = { 'go' } }
})


-- 键位
lvim.keys.insert_mode['<C-s>'] = '<ESC>:w<CR>'                -- 保存
lvim.keys.normal_mode['<C-s>'] = '<ESC>:w<CR>'                -- 保存
lvim.keys.normal_mode['go'] = '<ESC>:AerialToggle!<CR><C-W>l' -- 打开大纲并切换窗口
lvim.keys.normal_mode['<C-q>'] = '<ESC>:q<CR>'                -- 关闭窗口
lvim.keys.normal_mode['<M-q>'] = '<ESC>:bp | bd #<CR>'        -- 关闭buffer
lvim.keys.normal_mode['<M-h>'] = '<ESC>:bp<CR>'               -- 上一buffer
lvim.keys.normal_mode['<M-l>'] = '<ESC>:bn<CR>'               -- 下一buffer
lvim.keys.normal_mode['gm'] = '<ESC>:MinimapToggle<CR>'       -- 打开/关闭代码地图

-- hadronized/hop.nvim 快捷键
lvim.builtin.which_key.mappings['j'] = {
  name = 'jump',
  l = { ':HopLineMW<CR>', 'jump to line' },
  w = { ':HopWordMW<CR>', 'jump to word' },
  c = { ':HopChar1MW<CR>', 'jump to on char' },
  C = { ':HopChar2MW<CR>', 'jump to two chars' },
}
lvim.builtin.which_key.mappings['S'] = {              -- 滚动
  name = "scrollbind",
  b = { ':set scrollbind<CR>', 'set scrollbind' },    -- 当前页面同步滚动
  n = { ':set noscrollbind<CR>', 'set noscrollbind' } -- 取消当前页面同步滚动
}
lvim.keys.term_mode['<ESC><ESC>'] = [[<C-\><C-n>]]    -- 终端中进入normal_mode

-- wfxr/vim-interestingwords 快捷键
lvim.builtin.which_key.mappings['k'] = {
  name = "Highlight",
  k = { ":call InterestingWords('n')<cr>", "InterestingWords('n')" }, -- 高亮单词
  v = { ":call InterestingWords('v')<cr>", "InterestingWords('v')" }, -- 高亮选中段落
  K = { ":call UncolorAllWords()<cr>", "UncolorAllWords()" }          -- 取消高亮
}
lvim.keys.normal_mode['n'] = '<ESC>:call WordNavigation(1)<cr>'
lvim.keys.normal_mode['N'] = '<ESC>:call WordNavigation(0)<cr>'


lvim.transparent_window = true

lvim.builtin.gitsigns.opts.current_line_blame = true

-- 使用OSC 52联通剪切板
-- 大多数终端由于安全原因只支持单向OSC 52，双向互通可以用xclip
-- 支持OSC 52的终端有：
-- Windows - Windows Terminal
-- MacOS - iTerm2
-- Chromebook - hterm
-- alacritty
-- kitty
-- 复用终端 - tmux (支持双向)
-- 复用终端 - screen
local function my_paste()
  return function()
    --[ 返回 “” 寄存器的内容，用来作为 p 操作符的粘贴物 ]
    local content = vim.fn.getreg('"')
    return vim.split(content, '\n')
  end
end

local function useOSC52()
  if (os.getenv('SSH_TTY') == nil)
  then
    --[ 当前环境为本地环境，也包括 wsl ]
    vim.opt.clipboard:append("unnamedplus")
  else
    vim.opt.clipboard:append("unnamedplus")

    vim.g.clipboard = {
      name = 'OSC 52',
      copy = {
        ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
        ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
      },
      paste = {
        -- 单向OSC 52在lvim中使用p粘贴的时候会卡住，所以返回在nvim寄存器的值可以避免卡住
        ["+"] = my_paste(),
        ["*"] = my_paste(),

        -- 如果终端支持双向OSC 52，可以使用以下方式
        -- ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
        -- ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
      },
    }
  end
end

-- 按需打开
-- useOSC52()
