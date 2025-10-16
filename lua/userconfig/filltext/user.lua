local M = {}

function M.text()
  -- 获取当前年份
  local date = os.date("%Y/%m/%d")

  -- 获取git用户名
  local git_user = vim.fn.system("git config user.name"):gsub("%s+$", "")
  if git_user == "" then
    git_user = vim.fn.input("Show name:")
  end

  local git_email = vim.fn.system("git config user.email"):gsub("%s+$", "")
  if git_user == "" then
    git_user = vim.fn.input("Show email:")
  end

  local template = [[
@Author: %s %s
@Date: %s

]]

  return string.format(template, git_user, git_email, date)
end

return M
