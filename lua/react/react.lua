local r = {}

local function Reactor()
  return r
end

local function get_cell_observers(cell, cells)
  local found = false
  for _, other in ipairs(cells) do
    if cell == other then
      found = true
      break
    end
  end
  if not found then
    table.insert(cells, cell)

    for _, observer in ipairs(cell.observers) do
      if observer.observers ~= nil then
        get_cell_observers(observer, cells)
      end
    end
  end
end

function r.InputCell(n)
  local c = { value = n }

  c.observers = {}
  c.watch = function(callback)
    table.insert(c.observers, callback)
  end
  c.unwatch = function(callback)
    for i, other in ipairs(c.observers) do
      if other == callback then
        table.remove(c.observers, i)
        break
      end
    end
  end

  c.get_value = function()
    return c.value
  end
  c.set_value = function(j)
    local cells = {}
    local fn_val_pairs = {}
    for _, observer in ipairs(c.observers) do
      if observer.observers ~= nil then
        get_cell_observers(observer, cells)
      else
        table.insert(fn_val_pairs, { fn = observer, val = c.value })
        error()
      end
    end

    local prev_values = {}

    for _, cell in ipairs(cells) do
      table.insert(prev_values, cell.get_value())
    end

    c.value = j

    for i, cell in ipairs(cells) do
      local new = cell.get_value()
      if prev_values[i] ~= new then
        for _, observer in ipairs(cell.observers) do
          if observer.observers == nil then
            table.insert(fn_val_pairs, { fn = observer, val = cell.get_value() })
          end
        end
      end
    end

    for _, pair in ipairs(fn_val_pairs) do
      pair.fn(pair.val)
    end
  end

  return c
end

function r.ComputeCell(...)
  local c = { ... }
  c.func = table.remove(c)

  c.observers = {}
  c.watch = function(callback)
    table.insert(c.observers, callback)
  end
  c.unwatch = function(callback)
    for i, other in ipairs(c.observers) do
      if other == callback then
        table.remove(c.observers, i)
        break
      end
    end
  end

  for _, input in ipairs(c) do
    input.watch(c)
  end

  c.get_value = function()
    local input_values = {}
    for _, input in ipairs(c) do
      table.insert(input_values, input.get_value())
    end
    return c.func(table.unpack(input_values))
  end

  return c
end

return { Reactor = Reactor }
