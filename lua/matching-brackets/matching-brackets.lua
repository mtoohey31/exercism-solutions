local pairs = {
  ["["] = "]",
  ["{"] = "}",
  ["("] = ")",
}

return {
  valid = function(s)
    local expected_stack = {}
    for i = 1, #s, 1 do
      local c = s:sub(i, i)
      local pair = pairs[c]
      if pair == nil then
        if c == "]" or c == "}" or c == ")" then
          if c == expected_stack[#expected_stack] then
            expected_stack[#expected_stack] = nil
          else
            return false
          end
        end
      else
        table.insert(expected_stack, pair)
      end
    end
    return #expected_stack == 0
  end,
}
