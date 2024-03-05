-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
lvim.plugins = {
  { "fatih/vim-go" }, -- golang必备
  -- { "easymotion/vim-easymotion" }, -- 跳转
}

lvim.format_on_save = true
require('lspconfig').gopls.setup({
  settings = {
    gopls = {
      gofumpt = true
    }
  }
})


-- 键位
lvim.keys.insert_mode["<C-s>"] = "<ESC>:w<CR>" -- 保存
