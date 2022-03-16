local BinarySearchTree = {}
BinarySearchTree.__index = BinarySearchTree

function BinarySearchTree:new(v)
  local bst = { value = v }
  setmetatable(bst, BinarySearchTree)
  return bst
end

function BinarySearchTree:insert(v)
  if v <= self.value then
    if self.left == nil then
      self.left = BinarySearchTree:new(v)
    else
      self.left:insert(v)
    end
  elseif self.value < v then
    if self.right == nil then
      self.right = BinarySearchTree:new(v)
    else
      self.right:insert(v)
    end
  end
end

function BinarySearchTree:from_list(l)
  if #l == 0 then
    error("can't create a tree from an empty list")
  end

  local bst = BinarySearchTree:new(l[1])
  for i = 2, #l, 1 do
    bst:insert(l[i])
  end
  return bst
end

function BinarySearchTree:values()
  local curr = self
  local path = {}
  while curr.left ~= nil do
    table.insert(path, curr)
    curr = curr.left
  end

  return function()
    if curr == nil then
      return nil
    end

    local res = curr.value
    if curr.right ~= nil then
      curr = curr.right
      while curr.left ~= nil do
        table.insert(path, curr)
        curr = curr.left
      end
    else
      curr = path[#path]
      path[#path] = nil
    end
    return res
  end
end

return BinarySearchTree
