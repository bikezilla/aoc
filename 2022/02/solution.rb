#!ruby
input = (STDIN.tty? ? DATA : STDIN).readlines(chomp: true)

SHAPE_SCORES = {
  'X': 1, # Rock, also A
  'Y': 2, # Paper, also B
  'Z': 3, # Scissors, also C
}

GAME_SCORES = {
  'A X': 3,
  'A Y': 6,
  'A Z': 0,
  'B X': 0,
  'B Y': 3,
  'B Z': 6,
  'C X': 6,
  'C Y': 0,
  'C Z': 3,
}

input.
  reduce(0) do |score, game|
    game_score = GAME_SCORES.fetch(game.to_sym)
    my_move_score = SHAPE_SCORES.fetch(game.chars.last.to_sym)

    score + game_score + my_move_score
  end.
  then { p _1}

RESULT_SCORES = {
  X: 0, # Lose
  Y: 3, # Draw
  Z: 6, # Win
}

MOVES = {
  'A X': 3,
  'A Y': 1,
  'A Z': 2,
  'B X': 1,
  'B Y': 2,
  'B Z': 3,
  'C X': 2,
  'C Y': 3,
  'C Z': 1,
}

input.
  reduce(0) do |score, game|
    my_move_score = MOVES.fetch(game.to_sym)
    game_score = RESULT_SCORES.fetch(game.chars.last.to_sym)

    score + game_score + my_move_score
  end.
  then { p _1}

__END__
A Y
B X
C Z
