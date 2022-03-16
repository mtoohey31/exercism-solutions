local Set = {}
Set.__index = Set

function Set:is_empty()
  for _, _ in pairs(self) do
    return false
  end
  return true
end

function Set:contains(e)
  return self[e] ~= nil
end

function Set:is_subset(o)
  for k in pairs(self) do
    if o[k] == nil then
      return false
    end
  end
  return true
end

function Set:is_disjoint(o)
  for k in pairs(self) do
    if o[k] ~= nil then
      return false
    end
  end
  return true
end

function Set:equals(o)
  return self:is_subset(o) and o:is_subset(self)
end

function Set:add(e)
  self[e] = true
end

function Set:intersection(o)
  local s = {}
  setmetatable(s, Set)
  for k in pairs(self) do
    if o[k] ~= nil then
      s[k] = true
    end
  end
  return s
end

function Set:difference(o)
  local s = {}
  setmetatable(s, Set)
  for k in pairs(self) do
    if o[k] == nil then
      s[k] = true
    end
  end
  return s
end

function Set:union(o)
  local s = {}
  setmetatable(s, Set)
  for k in pairs(self) do
    s[k] = true
  end
  for k in pairs(o) do
    s[k] = true
  end
  return s
end

return function(...)
  local s = {}
  setmetatable(s, Set)
  for i = 1, select("#", ...) do
    s[select(i, ...)] = true
  end
  return s
end
