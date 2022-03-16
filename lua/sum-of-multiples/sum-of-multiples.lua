return function(numbers)
  return {
    to = function(to)
      local sum = 0
      local counted = {}
      for _, n in ipairs(numbers) do
        for i = n, to - 1, n do
          if counted[i] == nil then
            sum = sum + i
          end
          counted[i] = true
        end
      end
      return sum
    end,
  }
end
