local M = {}

function M.mit_license()
  -- 获取当前年份
  local year = os.date("%Y")

  -- 获取git用户名
  local git_user = vim.fn.system("git config user.name"):gsub("%s+$", "")
  if git_user == "" then
    git_user = vim.fn.input("Show name:")
  end

  -- MIT协议模板
  local mit_template = [[
MIT License

Copyright (c) %s %s

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

]]

  return string.format(mit_template, year, git_user)
end

function M.mit_head_license()
  -- 获取当前年份
  local year = os.date("%Y")

  -- 获取git用户名
  local git_user = vim.fn.system("git config user.name"):gsub("%s+$", "")
  if git_user == "" then
    git_user = vim.fn.input("Show name:")
  end

  local template = [[
Copyright (c) %s %s
Use of this source code is governed by an MIT-style
license that can be found in the LICENSE file.

]]
  return string.format(template, year, git_user)
end

return M
