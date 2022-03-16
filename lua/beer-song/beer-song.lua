local beer = {}

function beer.bottle_format(number)
  if number > 1 then
    return number .. " bottles"
  elseif number == 1 then
    return "1 bottle"
  else
    return "no more bottles"
  end
end

function beer.verse(number)
  if number == 0 then
    return "No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall.\n"
  elseif number == 1 then
    return "1 bottle of beer on the wall, 1 bottle of beer.\nTake it down and pass it around, no more bottles of beer on the wall.\n"
  else
    return beer.bottle_format(number)
      .. " of beer on the wall, "
      .. beer.bottle_format(number)
      .. " of beer.\nTake one down and pass it around, "
      .. beer.bottle_format(number - 1)
      .. " of beer on the wall.\n"
  end
end

function beer.sing(start, finish)
  local verses = {}
  for i = start, finish or 0, -1 do
    table.insert(verses, beer.verse(i))
  end
  return table.concat(verses, "\n")
end

return beer
