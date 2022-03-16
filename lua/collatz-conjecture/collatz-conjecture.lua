return function(n)
  if n < 1 then
    error("Only positive numbers are allowed")
  end

  local steps = 0
  local c = n
  while c ~= 1 do
    if c % 2 == 0 then
      c = c / 2
    else
      c = (3 * c) + 1
    end
    steps = steps + 1
  end
  return steps
end
