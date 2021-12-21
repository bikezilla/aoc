require 'pry'

FINISH = 21

def dprint(s)
  #print s
end

def roll
  r = 3.times.map { @dice.next }
  r.sum
end

def move(pos, draw)
  (pos + draw).then { _1 > 10 ? _1 % 10 : _1}.then { _1 == 0 ? 10 : _1 }
end

def game(p1, p2, s1, s2, d1, d2)
  signature = [p1, p2, s1, s2, d1, d2]

  dprint "Calling with #{p1} #{p2} #{s1} #{s2} #{d1} #{d2}\n"
  #binding.pry if p1 == 10 && p2 == 7 && s1 == 10 && s2 == 7 && d1 == 4 && d2 ==3
  if @cache[signature] == 1
    @cache_hits += 1
    @win1 += 1
  elsif @cache[signature] == 2
    @cache_hits += 1
    @win2 += 1
  end

  dprint "Player 1: rolls #{d1} from #{p1}"
  p1 = move(p1, d1)
  s1 += p1
  dprint " to #{p1} score #{s1}\n"

  if s1 >= FINISH
    @cache[signature] = 1
    @win1 += 1

    dprint "Player 1 wins\n"
  else
    dprint "Player 2: rolls #{d2} from #{p2}"
    p2 = move(p2, d2)
    s2 += p2
    dprint " to #{p2} score #{s2}\n"

    if s2 >= FINISH
      @cache[signature] = 2
      @win2 += 1

      dprint "Player 2 wins\n"
    else
      @draws.each do |d1, c1|
        @draws.each do |d2, c2|
          game(p1, p2, s1, s2, d1, d2)
        end
      end
    end
  end
end

input = (STDIN.tty? ? DATA : STDIN).readlines(chomp: true)
p1, p2 = input.map { _1.split(': ')[1].to_i }
p1, p2 = p2, p1
s1, s2 = 0, 0
@dice = (1..100).to_a.cycle

#@draws = [3, 4, 5,
         #4, 5, 6,
         #5, 6, 7,
         #4, 5, 6,
         #5, 6, 7,
         #6, 7, 8,
         #5, 6, 7,
         #6, 7, 8,
         #7, 8, 9]
#
#@draws = [2, 3,
          #3, 4]
@draws =  {3=>1, 4=>3, 5=>6, 6=>7, 7=>6, 8=>3, 9=>1}

@cache = {}
@cache_hits = 0
@win1 = 0
@win2 = 0

@draws.each do |d1, c1|
  @draws.each do |d2, c2|
    game(p1, p2, 0, 0, d1, d2)
  end
end

#pp @cache
p @cache.size
p @cache_hits
p @win1
p @win2

__END__
Player 1 starting position: 4
Player 2 starting position: 8
