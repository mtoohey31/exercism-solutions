local Robot = {}
Robot.__index = Robot

local names_so_far = {}

local min_uppercase_latin_byte = string.byte("A")
local max_uppercase_latin_byte = string.byte("Z")

local function generate_name()
  return table.concat({
    string.char(math.random(min_uppercase_latin_byte, max_uppercase_latin_byte)),
    string.char(math.random(min_uppercase_latin_byte, max_uppercase_latin_byte)),
    tostring(math.random(0, 9)),
    tostring(math.random(0, 9)),
    tostring(math.random(0, 9)),
  })
end

function Robot:new()
  local r = {}
  setmetatable(r, Robot)
  r:reset()
  return r
end

function Robot:reset()
  self.name = generate_name()
  while names_so_far[self.name] ~= nil do
    self.name = generate_name()
  end
  names_so_far[self.name] = true
end

return Robot
