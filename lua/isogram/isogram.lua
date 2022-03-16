return function(s)
  local seen = {}
  for c in s:lower():gmatch("%w") do
    if seen[c] ~= nil then
      return false
    else
      seen[c] = 0
    end
  end
  return true
end
