return function(array, target)
  local min = 1
  local max = #array
  while min <= max do
    local curr_index = math.floor((min + max) / 2)
    local curr = array[curr_index]
    if target == curr then
      return curr_index
    elseif target < curr then
      max = curr_index - 1
    else
      min = curr_index + 1
    end
  end
  return -1
end
