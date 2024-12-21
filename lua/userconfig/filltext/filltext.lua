local M = {}

local function insert(text)
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

  local api = require('Comment.api')
  local config = require('Comment.config')
  api.toggle.blockwise.count(lines, config)
end

local mit = require("userconfig.filltext.mit")
function M.insert_mit_license()
  local text = mit.mit_license()
  insert(text)
end

return M
