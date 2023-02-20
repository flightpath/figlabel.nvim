local function figlabel(text, prefix)
  if text == "" then
    put(text)
    print("error: no text supplied")
    return
  end
  if prefix == "" then
    put(prefix)
    print("error: no prefix supplied")
    return
  end

  local fn = vim.fn
  local result = fn.systemlist('figlet '..text)
  local linenr = fn.line('.',fn.bufwinid(fn.bufnr()))
  for k,v in pairs(result) do
    local txt = prefix..' '..result[k]
    result[k] = fn.substitute(txt, " *$", "", "")
  end
  fn.append(linenr, result)
end

return {
  figlabel = figlabel
}
