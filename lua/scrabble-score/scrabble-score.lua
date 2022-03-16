local values = {
  A = 1,
  E = 1,
  I = 1,
  O = 1,
  U = 1,
  L = 1,
  N = 1,
  R = 1,
  S = 1,
  T = 1,
  D = 2,
  G = 2,
  B = 3,
  C = 3,
  M = 3,
  P = 3,
  F = 4,
  H = 4,
  V = 4,
  W = 4,
  Y = 4,
  K = 5,
  J = 8,
  X = 8,
  Q = 10,
  Z = 10,
}

local function score(word)
  local score_so_far = 0
  if word == nil then
    return score_so_far
  end
  for i = 1, #word, 1 do
    score_so_far = score_so_far + values[string.upper(word:sub(i, i))]
  end
  return score_so_far
end

return { score = score }
