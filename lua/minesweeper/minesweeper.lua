local function transform(board)
  local new_board = { board[1] }
  local first_width = #board[1]
  for i = 2, #board, 1 do
    assert(#board[i] == first_width)
  end
  for i = 2, #board - 1, 1 do
    table.insert(new_board, board[i])
    for j = 2, #board[1] - 1, 1 do
      assert(board[i]:sub(j, j) == " " or board[i]:sub(j, j) == "*")
      if board[i]:sub(j, j) ~= "*" then
        local mines_so_far = 0
        if i > 2 and board[i - 1]:sub(j, j) == "*" then
          mines_so_far = mines_so_far + 1
        end
        if i > 2 and j > 2 and board[i - 1]:sub(j - 1, j - 1) == "*" then
          mines_so_far = mines_so_far + 1
        end
        if j > 2 and board[i]:sub(j - 1, j - 1) == "*" then
          mines_so_far = mines_so_far + 1
        end
        if i < #board - 1 and j > 2 and board[i + 1]:sub(j - 1, j - 1) == "*" then
          mines_so_far = mines_so_far + 1
        end
        if i < #board - 1 and board[i + 1]:sub(j, j) == "*" then
          mines_so_far = mines_so_far + 1
        end
        if i < #board - 1 and j < #board[1] - 1 and board[i + 1]:sub(j + 1, j + 1) == "*" then
          mines_so_far = mines_so_far + 1
        end
        if j < #board[1] - 1 and board[i]:sub(j + 1, j + 1) == "*" then
          mines_so_far = mines_so_far + 1
        end
        if i > 2 and j < #board[1] - 1 and board[i - 1]:sub(j + 1, j + 1) == "*" then
          mines_so_far = mines_so_far + 1
        end
        if mines_so_far ~= 0 then
          new_board[i] = new_board[i]:sub(1, j - 1) .. mines_so_far .. new_board[i]:sub(j + 1)
        end
      end
    end
  end
  table.insert(new_board, board[#board])
  return new_board
end

return {
  transform = transform,
}
