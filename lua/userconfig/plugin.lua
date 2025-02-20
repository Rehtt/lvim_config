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

  -- -- 折叠代码 按需打开，觉得先熟悉自带的折叠命令比较好
  -- {
  --   'kevinhwang91/nvim-ufo',
  --   dependencies = {
  --     'kevinhwang91/promise-async',
  --   },
  --   event = "BufReadPost",
  --   config = function()
  --     require("ufo").setup({
  --       provider_selector = function(bufnr, filetype, buftype)
  --         return { "treesitter", "indent" }
  --       end,
  --       fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
  --         local newVirtText = {}
  --         local suffix = (' 󰁂 %d '):format(endLnum - lnum)
  --         local sufWidth = vim.fn.strdisplaywidth(suffix)
  --         local targetWidth = width - sufWidth
  --         local curWidth = 0
  --         for _, chunk in ipairs(virtText) do
  --           local chunkText = chunk[1]
  --           local chunkWidth = vim.fn.strdisplaywidth(chunkText)
  --           if targetWidth > curWidth + chunkWidth then
  --             table.insert(newVirtText, chunk)
  --           else
  --             chunkText = truncate(chunkText, targetWidth - curWidth)
  --             local hlGroup = chunk[2]
  --             table.insert(newVirtText, { chunkText, hlGroup })
  --             chunkWidth = vim.fn.strdisplaywidth(chunkText)
  --             -- str width returned from truncate() may less than 2nd argument, need padding
  --             if curWidth + chunkWidth < targetWidth then
  --               suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
  --             end
  --             break
  --           end
  --           curWidth = curWidth + chunkWidth
  --         end
  --         table.insert(newVirtText, { suffix, 'MoreMsg' })
  --         return newVirtText
  --       end
  --     })
  --     vim.opt.foldenable = true     -- 保留折叠功能
  --     vim.opt.foldlevel = 99        -- 设置初始折叠级别为 99
  --     vim.opt.foldlevelstart = 99   -- 启动时展开所有折叠
  --     vim.opt.foldcolumn = "auto:9" -- 显示一列折叠标志
  --     vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep:│,foldclose:]]
  --   end
  -- },

}
