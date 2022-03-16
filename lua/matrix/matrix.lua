return function(s)
  local matrix = {}
  for s_row in s:gmatch("[^\n]*\n?") do
    local row = {}
    for s_num in s_row:gmatch("%d+ ?") do
      table.insert(row, tonumber(s_num))
    end
    table.insert(matrix, row)
  end
  matrix.row = function(i)
    return matrix[i]
  end
  matrix.column = function(i)
    local column = {}
    for j = 1, #matrix, 1 do
      table.insert(column, matrix[j][i])
    end
    return column
  end
  return matrix
end
