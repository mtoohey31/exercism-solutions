local DNA = {}
DNA.__index = DNA

local nucleotides = { "A", "C", "G", "T" }

function contains(xs, x)
  for _, v in pairs(xs) do
    if v == x then
      return true
    end
  end
  return false
end

function DNA:new(chain)
  local dna = { nucleotideCounts = {} }
  for _, n in ipairs(nucleotides) do
    dna.nucleotideCounts[n] = 0
  end
  for c in chain:gmatch(".") do
    if contains(nucleotides, c) then
      dna.nucleotideCounts[c] = dna.nucleotideCounts[c] + 1
    else
      error("Invalid Nucleotide")
    end
  end
  setmetatable(dna, DNA)
  return dna
end

function DNA:count(c)
  if contains(nucleotides, c) then
    return self.nucleotideCounts[c]
  else
    error("Invalid Nucleotide")
  end
end

return DNA
