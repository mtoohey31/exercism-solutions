local translations = {
  AUG = "Methionine",
  UUU = "Phenylalanine",
  UUC = "Phenylalanine",
  UUA = "Leucine",
  UUG = "Leucine",
  UCU = "Serine",
  UCC = "Serine",
  UCA = "Serine",
  UCG = "Serine",
  UAU = "Tyrosine",
  UAC = "Tyrosine",
  UGU = "Cysteine",
  UGC = "Cysteine",
  UGG = "Tryptophan",
  UAA = "STOP",
  UAG = "STOP",
  UGA = "STOP",
}

local function translate_codon(codon)
  local translation = translations[codon]
  if translation == nil then
    error("unknown codon")
  end
  return translation
end

local function translate_rna_strand(rna_strand)
  local translation_so_far = {}
  for i = 1, #rna_strand - 2, 3 do
    local curr_translation = translate_codon(rna_strand:sub(i, i + 2))
    if curr_translation == "STOP" then
      break
    else
      table.insert(translation_so_far, curr_translation)
    end
  end
  return translation_so_far
end

return {
  codon = translate_codon,
  rna_strand = translate_rna_strand,
}
