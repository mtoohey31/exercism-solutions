local translations = {
  G = "C",
  C = "G",
  T = "A",
  A = "U",
}

return function(dna)
  local translation = {}
  for i = 1, #dna, 1 do
    table.insert(translation, translations[dna:sub(i, i)])
  end
  return table.concat(translation)
end
