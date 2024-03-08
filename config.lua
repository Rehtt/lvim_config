-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- 插件
lvim.plugins        = {
  { 'fatih/vim-go' }, -- golang必备

  -- 跳转
  {
    'hadronized/hop.nvim',
    config = function()
      require('hop').setup {}
    end
  },

  -- copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end
  },


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
}

-- 格式化
lvim.format_on_save = true
local formatters    = require('lvim.lsp.null-ls.formatters')
formatters.setup({
  { name = 'gofumpt',   filetype = { 'go' } },
  { name = 'goimports', filetype = { 'go' } }
})


-- 键位
lvim.keys.insert_mode['<C-s>'] = '<ESC>:w<CR>'          -- 保存
lvim.keys.normal_mode['<C-s>'] = '<ESC>:w<CR>'          -- 保存
lvim.keys.normal_mode['go'] = '<ESC>:AerialToggle!<CR>' -- 大纲
lvim.keys.normal_mode['<C-q>'] = '<ESC>:q<CR>'          -- 关闭窗口
lvim.keys.normal_mode['<M-q>'] = '<ESC>:bp | bd #<CR>'  -- 关闭buffer
lvim.builtin.which_key.mappings['j'] = {
  name = 'jump',
  l = { ':HopLineMW<CR>', 'jump to line' },
  w = { ':HopWordMW<CR>', 'jump to word' },
  c = { ':HopChar1MW<CR>', 'jump to on char' },
  C = { ':HopChar2MW<CR>', 'jump to two chars' },
}


lvim.transparent_window = true

lvim.builtin.gitsigns.opts.current_line_blame = true
