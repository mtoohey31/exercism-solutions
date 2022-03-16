local function path_from_root(node_name, tree, path)
  if node_name == tree[1] then
    table.insert(path, node_name)
    return true
  end

  if tree[2] ~= nil then
    table.insert(path, tree[1])
    for i = 1, #tree[2], 1 do
      if path_from_root(node_name, tree[2][i], path) then
        return true
      end
    end
    table.remove(path)
  end
  return false
end

local function splice_paths(a, b)
  while #a > 1 and #b > 1 and a[1] == b[1] and a[2] == b[2] do
    table.remove(a, 1)
    table.remove(b, 1)
  end

  local spliced = {}
  for i = 1, #a, 1 do
    spliced[i] = a[#a + 1 - i]
  end
  for i = 2, #b, 1 do
    spliced[#a + i - 1] = b[i]
  end
  return spliced
end

local function pov_from(node_name)
  return {
    of = function(tree)
      local path_from = {}
      if not path_from_root(node_name, tree, path_from) then
        error("node not found")
      end

      local curr = tree
      for i = 2, #path_from, 1 do
        for j = 1, #curr[2], 1 do
          if curr[2][j][1] == path_from[i] then
            curr = curr[2][j]
            break
          end
        end
      end

      local new_tree = { node_name, {} }
      if curr[2] ~= nil then
        for i = 1, #curr[2], 1 do
          table.insert(new_tree[2], curr[2][i])
        end
      end
      curr = new_tree

      table.remove(path_from)

      while #path_from ~= 0 do
        local curr_parent = tree
        for i = 1, #path_from, 1 do
          for j = 1, #curr_parent[2], 1 do
            if curr_parent[2][j][1] == path_from[i] then
              curr_parent = curr_parent[2][j]
              break
            end
          end
        end

        table.insert(curr[2], { curr_parent[1], {} })
        for i = 1, #curr_parent[2], 1 do
          if curr_parent[2][i][1] ~= curr[1] then
            table.insert(curr[2][#curr[2]][2], curr_parent[2][i])
          end
        end

        curr = curr[2][#curr[2]]

        table.remove(path_from)
      end

      if #curr[2] == 0 then
        table.remove(curr)
      end

      if new_tree[2] ~= nil and #new_tree[2] == 0 then
        table.remove(new_tree)
      end

      return new_tree
    end,
  }
end

local function path_from(source)
  return {
    to = function(dest)
      return {
        of = function(tree)
          local source_path = {}
          local dest_path = {}

          if not path_from_root(source, tree, source_path) then
            error("source not found")
          end
          if not path_from_root(dest, tree, dest_path) then
            error("destination not found")
          end

          return splice_paths(source_path, dest_path)
        end,
      }
    end,
  }
end

return {
  pov_from = pov_from,
  path_from = path_from,
}
