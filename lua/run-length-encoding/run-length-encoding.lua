local min_digit_byte = string.byte("0")
local max_digit_byte = string.byte("9")

local function is_digit(c)
  local byte = string.byte(c)
  return max_digit_byte >= byte and byte >= min_digit_byte
end

return {
  encode = function(s)
    local prev = s:sub(1, 1)
    local prev_count = 1
    local encoded_so_far = {}
    for curr in s:sub(2):gmatch(".") do
      if curr == prev then
        prev_count = prev_count + 1
      else
        if prev_count == 1 then
          table.insert(encoded_so_far, prev)
        else
          table.insert(encoded_so_far, tostring(prev_count) .. prev)
        end
        prev = curr
        prev_count = 1
      end
    end
    if prev_count == 1 then
      table.insert(encoded_so_far, prev)
    else
      table.insert(encoded_so_far, tostring(prev_count) .. prev)
    end
    return table.concat(encoded_so_far)
  end,

  decode = function(s)
    local count_so_far = {}
    local decoded_so_far = {}
    for i = 1, #s, 1 do
      local c = s:sub(i, i)
      if is_digit(c) then
        table.insert(count_so_far, c)
      else
        if #count_so_far == 0 then
          table.insert(decoded_so_far, c)
        else
          local count = tonumber(table.concat(count_so_far))
          count_so_far = {}
          table.insert(decoded_so_far, string.rep(c, count))
        end
      end
    end
    return table.concat(decoded_so_far)
  end,
}
