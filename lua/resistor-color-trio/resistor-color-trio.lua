local digits = {
  black = 0,
  brown = 1,
  red = 2,
  orange = 3,
  yellow = 4,
  green = 5,
  blue = 6,
  violet = 7,
  grey = 8,
  white = 9,
}

return {
  decode = function(c1, c2, c3)
    local raw_res = ((digits[c1] * 10) + digits[c2]) * (math.pow(10, digits[c3]))
    if raw_res % 1000 == 0 then
      return raw_res / 1000, "kiloohms"
    else
      return raw_res, "ohms"
    end
  end,
}
