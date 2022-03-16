local BankAccount = {}
BankAccount.__index = BankAccount

function BankAccount:new()
  local a = { b = 0 }
  setmetatable(a, BankAccount)
  return a
end

function BankAccount:balance()
  return self.b
end

function BankAccount:deposit(m)
  if m <= 0 then
    error("non-positive deposit amount")
  end
  if self.closed then
    error("account is closed")
  end
  self.b = self.b + m
end

function BankAccount:withdraw(m)
  if m <= 0 then
    error("non-positive withdrawl amount")
  end
  if m > self.b then
    error("insufficient funds")
  end
  if self.closed then
    error("account is closed")
  end
  self.b = self.b - m
end

function BankAccount:close()
  self.closed = true
end

return BankAccount
