local M = {}

function M.insert(text)
  local lines = 0
  for c in text:gmatch("(.)") do
    if c == "\n" then
      lines = lines + 1
    end
  end

  -- 将文本插入到文件顶部
  vim.api.nvim_command("normal! ggO")
  vim.api.nvim_paste(text, false, -1)
  vim.api.nvim_command("normal! gg0")

  vim.api.nvim_win_set_cursor(0, { 1, 0 })
  local api = require('Comment.api')
  api.toggle.linewise.count(lines)
end

function M.insert_file_and_comment(filepath, text)
  -- 计算插入文本的行数
  local lines = vim.split(text, '\n')

  -- 加载或打开 buffer
  local bufnr = vim.fn.bufadd(filepath)
  vim.fn.bufload(bufnr)
  vim.api.nvim_set_current_buf(bufnr)

  vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, lines)
  vim.api.nvim_win_set_cursor(0, { 1, 0 })

  -- 选择插入的行进行注释
  local api = require("Comment.api")
  api.toggle.linewise.count(#lines)
end

local mit = require("userconfig.filltext.mit")
local user = require("userconfig.filltext.user")
function M.insert_mit_license(filepath)
  local text = mit.mit_license()
  if filepath == nil then
    M.insert(text)
    return
  end
  M.insert_file_and_comment(filepath, text)
end

function M.insert_mit_head_license(filepath)
  local text = mit.mit_head_license()
  if filepath == nil then
    M.insert(text)
    return
  end
  M.insert_file_and_comment(filepath, text)
end

function M.insert_user_info(filepath)
  local text = user.text()
  if filepath == nil then
    M.insert(text)
    return
  end
  M.insert_file_and_comment(filepath, text)
end

return M
