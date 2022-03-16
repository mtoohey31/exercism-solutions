return function(which)
  local triangle_rows = {}
  local offset = which:byte() - string.byte("A")
  for i = 0, offset, 1 do
    local curr_char = string.char(which:byte() - i)
    local center_chars = 1 + (2 * (offset - (i + 1)))
    if center_chars >= 0 then
      table.insert(
        triangle_rows,
        string.rep(" ", i) .. curr_char .. string.rep(" ", center_chars) .. curr_char .. string.rep(" ", i)
      )
    else
      table.insert(triangle_rows, string.rep(" ", i) .. curr_char .. string.rep(" ", i))
    end
  end
  local diamond_rows = {}
  for i = #triangle_rows, 2, -1 do
    table.insert(diamond_rows, triangle_rows[i])
  end
  for i = 1, #triangle_rows, 1 do
    table.insert(diamond_rows, triangle_rows[i])
  end
  return table.concat(diamond_rows, "\n") .. "\n"
end
