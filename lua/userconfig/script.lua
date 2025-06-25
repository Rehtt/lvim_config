-- 将[doc]转为[unix]
vim.api.nvim_create_user_command('Dos2unix', function()
  local current_file = vim.fn.expand('%:p')
  if current_file == '' then
    vim.notify('没有打开的文件', vim.log.levels.ERROR)
    return
  end

  -- 保存当前文件
  vim.cmd('write')

  -- 执行dos2unix命令
  local command = string.format('dos2unix %s', vim.fn.shellescape(current_file))
  local output = vim.fn.system(command)

  if vim.v.shell_error == 0 then
    vim.notify('文件格式转换成功: ' .. current_file, vim.log.levels.INFO)
    -- 重新加载文件以显示更改
    vim.cmd('edit!')
  else
    vim.notify('转换失败: ' .. output, vim.log.levels.ERROR)
  end
end, {
  desc = '将当前文件从DOS格式转换为Unix格式',
  bang = false
})
