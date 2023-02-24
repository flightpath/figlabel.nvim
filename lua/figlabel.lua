--   __ _       _       _          _         _             _
--  / _(_) __ _| | __ _| |__   ___| |  _ __ | |_   _  __ _(_)_ __
-- | |_| |/ _` | |/ _` | '_ \ / _ \ | | '_ \| | | | |/ _` | | '_ \
-- |  _| | (_| | | (_| | |_) |  __/ | | |_) | | |_| | (_| | | | | |
-- |_| |_|\__, |_|\__,_|_.__/ \___|_| | .__/|_|\__,_|\__, |_|_| |_|
--        |___/                       |_|            |___/

---@mod figlabel Figlabel
---@brief [[
---Figlabel appends a figlet created label after the current line.
---
--- Usage:
---    :Figlabel <label text> <comment prefix>
---
---    label text:     text string - escape spaces with a '\'
---                    for `\` use '\\'
---    comment prefix: comment prefix for language
---@brief ]]
local function flabel(text, prefix)
  local fn = vim.fn
  -- get figlet output into a list
  local result = fn.systemlist('figlet '..text)
  -- get current line # in current buffer
  local linenr = fn.line('.',fn.bufwinid(fn.bufnr()))
  -- remove all trailing whitspace from each list line
  for k, _ in pairs(result) do
    local txt = prefix..' '..result[k]
    result[k] = fn.substitute(txt, " *$", "", "")
  end
  -- append figlet list after current line
  fn.append(linenr, result)
end

-- create 'Figlabel' Ex command
vim.api.nvim_create_user_command("Figlabel",
  function(input)
    local text, prefix
    local args = input.fargs
    if #args == 0 then
      print("error: no text argument supplied")
      return
    elseif #args == 1 then
      print("error: no prefix argument supplied")
      return
    else
      text = args[1]
      prefix = args[2]
    end
    flabel(text, prefix)
  end,
  {nargs = "+", desc = "create a figlet label", force = true})

---@export figlabel
