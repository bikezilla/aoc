require 'pry'

FINISH = 1000

def roll
  r = 3.times.map { @dice.next }
  print " rolls #{r.join('+')} "
  r.sum
end

def move(pos, draw)
  (pos + draw).then { _1 > 10 ? _1 % 10 : _1}.then { _1 == 0 ? 10 : _1 }
end

def game(p1, p2, s1, s2)
  print "Player 1: from #{p1}"
  p1 = move(p1, roll)
  s1 += p1
  print " to #{p1} score #{s1}\n"

  if s1 >= FINISH
    p 'Player 1 wins'
  else
    print "Player 2: from #{p2}"
    p2 = move(p2, roll)
    s2 += p2
    print " to #{p2} score #{s2}\n"

    if s2 >= FINISH
      p 'Player 2 wins'
    else
      game(p1, p2, s1, s2)
    end
  end
end

input = (STDIN.tty? ? DATA : STDIN).readlines(chomp: true)
p1, p2 = input.map { _1.split(': ')[1].to_i }
s1, s2 = 0, 0
@dice = (1..100).to_a.cycle

game(p1, p2, s1, s2)

__END__
Player 1 starting position: 4
Player 2 starting position: 8
