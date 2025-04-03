-- 键位
lvim.keys.insert_mode['<C-s>']        = '<ESC>:w<CR>'                            -- 保存
lvim.keys.normal_mode['<C-s>']        = '<ESC>:w<CR>'                            -- 保存
lvim.keys.normal_mode['go']           = '<ESC>:AerialToggle!<CR><C-W>l'          -- 打开大纲并切换窗口
lvim.keys.normal_mode['<C-q>']        = '<ESC>:q<CR>'                            -- 关闭窗口
lvim.keys.normal_mode['<M-q>']        = '<ESC>:bp | bd #<CR>'                    -- 关闭buffer
lvim.keys.normal_mode['<M-h>']        = '<ESC>:bp<CR>'                           -- 上一buffer
lvim.keys.normal_mode['<M-l>']        = '<ESC>:bn<CR>'                           -- 下一buffer
lvim.keys.normal_mode['gm']           = '<ESC>:MinimapToggle<CR>'                -- 打开/关闭代码地图
lvim.builtin.cmp.mapping["<C-z>"]     = require("cmp.config.mapping").complete() -- cmp手动补全，因为默认的<C-Spect>和windows10 11输入法冲突
lvim.keys.insert_mode['<M-h>']        = '<C-o>b'                                 -- 移动光标到左边一个单词
lvim.keys.insert_mode['<M-l>']        = '<C-o>w'                                 -- 移动光标到右边一个单词
lvim.keys.insert_mode['<C-h>']        = '<C-o>h'                                 -- 移动光标到左边一个字符
lvim.keys.insert_mode['<C-l>']        = '<C-o>l'                                 -- 移动光标到右边一个字符

-- hadronized/hop.nvim 快捷键
lvim.builtin.which_key.mappings['j']  = {
  name = 'jump',
  l = { ':HopLineMW<CR>', 'jump to line' },
  w = { ':HopWordMW<CR>', 'jump to word' },
  c = { ':HopChar1MW<CR>', 'jump to on char' },
  C = { ':HopChar2MW<CR>', 'jump to two chars' },
}
lvim.builtin.which_key.mappings['S']  = {              -- 滚动
  name = "scrollbind",
  b = { ':set scrollbind<CR>', 'set scrollbind' },     -- 当前页面同步滚动
  n = { ':set noscrollbind<CR>', 'set noscrollbind' }  -- 取消当前页面同步滚动
}
lvim.keys.term_mode['<ESC><ESC>']     = [[<C-\><C-n>]] -- 终端中进入normal_mode

-- wfxr/vim-interestingwords 快捷键
lvim.builtin.which_key.mappings['k']  = {
  name = "Highlight",
  k = { ":call InterestingWords('n')<cr>", "InterestingWords('n')" }, -- 高亮单词
  v = { ":call InterestingWords('v')<cr>", "InterestingWords('v')" }, -- 高亮选中段落
  K = { ":call UncolorAllWords()<cr>", "UncolorAllWords()" }          -- 取消高亮
}
-- 在选中模式下高亮
lvim.builtin.which_key.vmappings['k'] = {
  name = "Highlight",
  k = { ":call InterestingWords('v')<cr>", "InterestingWords('v')" }
}
lvim.keys.normal_mode['n']            = '<ESC>:call WordNavigation(1)<cr>'
lvim.keys.normal_mode['N']            = '<ESC>:call WordNavigation(0)<cr>'

-- 禁用vim-interestingwords默认快捷键
vim.g.interestingWordsDefaultMappings = 0

local functions                       = require('userconfig.filltext.filltext')
lvim.builtin.which_key.mappings['F']  = {
  name = "Fill Text",
  m = { function() functions.insert_mit_license() end, "MIT" },
  u = { function() functions.insert_user_info() end, "User Info" }
}
