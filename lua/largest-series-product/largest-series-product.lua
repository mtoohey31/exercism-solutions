return function(config)
  if config.span < 0 then
    error("negative spans are invalid")
  elseif config.span > #config.digits then
    error("digits are too short for span")
  end

  local s = 1
  local e = 1
  local prod = 1

  while s >= e - config.span + 1 and e <= #config.digits do
    local c = tonumber(config.digits:sub(e, e))
    if c == 0 then
      s = e + 1
      e = s
      prod = 1
    else
      prod = prod * c
      e = e + 1
    end
  end

  if s ~= e - config.span then
    return 0
  end

  local max = prod
  while e <= #config.digits do
    local c = tonumber(config.digits:sub(e, e))

    if c == 0 then
      s = e + 1
      e = s
      prod = 1

      while s > e - config.span and e <= #config.digits do
        c = tonumber(config.digits:sub(e, e))
        if c == 0 then
          s = e + 1
          e = s
          prod = 1
        else
          prod = prod * c
          e = e + 1
        end
      end

      if s ~= e - config.span then
        return max
      end
    else
      local d = tonumber(config.digits:sub(s, s))
      prod = (prod / d) * c
      if prod > max then
        max = prod
      end
      s = s + 1
      e = e + 1
    end
  end
  return max
end
