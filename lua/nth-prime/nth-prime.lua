local function is_prime(n)
  for i = 2, math.floor(math.sqrt(n)), 1 do
    if n % i == 0 then
      return false
    end
  end
  return true
end

return function(n)
  if n <= 0 then
    error("n must be positive")
  end
  local primes_so_far = 0
  local curr = 1
  while primes_so_far < n do
    curr = curr + 1
    if is_prime(curr) then
      primes_so_far = primes_so_far + 1
    end
  end
  return curr
end
