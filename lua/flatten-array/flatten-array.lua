local function flatten(input)
  local res = {}
  for _, v1 in ipairs(input) do
    if type(v1) == "table" then
      for _, v2 in ipairs(flatten(v1)) do
        table.insert(res, v2)
      end
    else
      table.insert(res, v1)
    end
  end
  return res
end

return flatten
