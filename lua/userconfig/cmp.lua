-- cmp配置
-- codeium.nvim
table.insert(lvim.builtin.cmp.sources, 1, { name = "codeium" })
lvim.builtin.cmp.formatting.source_names.codeium = "(Codeium)" -- 显示的名称
local default_format                             = lvim.builtin.cmp.formatting.format
lvim.builtin.cmp.formatting.format               = function(entry, vim_item)
  vim_item = default_format(entry, vim_item)
  -- 图标
  if entry.source.name == "codeium" then
    vim_item.kind = lvim.icons.ui.Fire
    vim_item.kind_hl_group = "CmpItemKindTabnine"
  end
  return vim_item
end

-- 修改代码提示器光标逻辑
lvim.builtin.cmp.preselect                       = "none"
lvim.builtin.cmp.completion.completeopt          = "menu,menuone,noinsert"
