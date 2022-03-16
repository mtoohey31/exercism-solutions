local function to_decimal(input)
  local curr = 0
  for c in input:gmatch(".") do
    if c == "0" then
      curr = curr * 2
    elseif c == "1" then
      curr = (curr * 2) + 1
    else
      return 0
    end
  end
  return curr
end

return {
  to_decimal = to_decimal,
}
