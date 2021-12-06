Number = Struct.new :value, :highlighted, keyword_init: true

def read_input
  input, *boards = File.read('../input/04.txt').split("\n\n")

  [input.split(',').map(&:to_i), boards.map { _1.split("\n").map(&:split).map { |a| a.map { |i| Number.new(value: i.to_i) } } }]
end

def highlight(number, boards)
  boards.map { |board| board.map { |row| row.map { |e| Number.new(value: e.value, highlighted: e.highlighted || e.value == number) } } }
end

def wins?(board)
  board.any? { |row| row.all?(&:highlighted) } || board.transpose.any? { |row| row.all?(&:highlighted) }
end

def board_score(board)
  board.flatten.reject(&:highlighted).sum { _1.value }
end

def first_to_win(input, boards)
  boards_copy = nil
  input.each do |number|
    boards_copy = highlight number, boards_copy || boards
    winning_board = boards_copy.find { wins?(_1) }

    return number * board_score(winning_board) if winning_board
  end
end

def last_to_win(input, boards)
  boards_copy = nil
  input.each do |number|
    boards_copy = highlight number, boards_copy || boards

    return number * board_score(boards_copy.first) if boards_copy.one? && wins?(boards_copy.first)

    boards_copy = boards_copy.reject { wins? _1 }
  end
end

input, boards = read_input

p first_to_win(input, boards)
p last_to_win(input, boards)

