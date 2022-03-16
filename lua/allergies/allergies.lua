local items = {
  "eggs",
  "peanuts",
  "shellfish",
  "strawberries",
  "tomatoes",
  "chocolate",
  "pollen",
  "cats",
}

local function list(score)
  local items_so_far = {}
  local curr_score = score
  while curr_score > 0 do
    local exponent = math.floor(math.log(curr_score, 2))
    local diff = math.pow(2, exponent)
    -- NOTE: we don't need to check for out of bounds things because indexing
    -- out of bounds in lua returns nil, and inserting nil into a table has no
    -- effect
    table.insert(items_so_far, items[exponent + 1])
    curr_score = curr_score - diff
  end
  for i = 1, #items_so_far / 2, 1 do
    items_so_far[i], items_so_far[#items_so_far - i + 1] = items_so_far[#items_so_far - i + 1], items_so_far[i]
  end
  return items_so_far
end

local function allergic_to(score, which)
  for _, item in ipairs(list(score)) do
    if item == which then
      return true
    end
  end
  return false
end

return {
  list = list,
  allergic_to = allergic_to,
}
