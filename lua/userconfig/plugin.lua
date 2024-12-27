-- 插件
lvim.plugins = {
  {
    'fatih/vim-go',
    config = function()
      -- 使用gopls内置的gofumpt
      vim.cmd('let g:go_gopls_gofumpt = 1')
    end
  }, -- golang必备

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
  --   "Exafunction/codeium.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "hrsh7th/nvim-cmp",
  --   },
  --   config = function()
  --     require("codeium").setup({})
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

  -- 获取插件启动时间
  {
    'dstein64/vim-startuptime'
  },
}
