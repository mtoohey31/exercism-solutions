return function(s)
  local lines = {}
  for line in s:gmatch("[^\n]*\n?") do
    -- remove the trailing space
    if line:sub(#line, #line) == "\n" then
      line = line:sub(1, #line - 1)
    end
    table.insert(lines, line)
  end

  local max_width = #lines[1]

  for i = 1, #lines, 1 do
    local max_past_here = 0
    for j = i + 1, #lines, 1 do
      if #lines[j] > max_past_here then
        max_past_here = #lines[j]
      end
    end
    lines[i] = lines[i] .. string.rep(" ", max_past_here - #lines[i])
    if max_past_here > max_width then
      max_width = max_past_here
    end
  end

  local transposed = {}
  for i = 1, max_width, 1 do
    local line = {}
    for j = 1, #lines, 1 do
      table.insert(line, lines[j]:sub(i, i))
    end
    table.insert(transposed, table.concat(line))
  end

  return table.concat(transposed, "\n")
end
