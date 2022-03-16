local function reduce(xs, value, f)
  local curr = value
  for _, x in ipairs(xs) do
    curr = f(x, curr)
  end
  return curr
end

local function map(xs, f)
  local res = {}
  for _, x in ipairs(xs) do
    table.insert(res, f(x))
  end
  return res
end

local function filter(xs, pred)
  local res = {}
  for _, x in ipairs(xs) do
    if pred(x) then
      table.insert(res, x)
    end
  end
  return res
end

return {
  map = map,
  reduce = reduce,
  filter = filter,
}
