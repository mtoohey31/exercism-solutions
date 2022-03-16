return function(amount, values)
  local change = {}
  for i = 1, #values, 1 do
    change[i] = 0
  end
  local remaining = amount
  while remaining > 0 do
    local max_subtractable = -1
    for i, c in ipairs(values) do
      if c <= remaining and (max_subtractable == -1 or c > values[max_subtractable]) then
        max_subtractable = i
      end
    end
    if max_subtractable == -1 then
      return nil
    else
      remaining = remaining - values[max_subtractable]
      change[max_subtractable] = change[max_subtractable] + 1
    end
  end
  return change
end
