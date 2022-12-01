require 'pry'

class Cache
  attr_reader :iterations, :hits

  def initialize
    @cache = {}
    @iterations = 0
    @hits = 0
  end

  def inc
    @iterations += 1
  end

  def hit
    @hits += 1
  end

  def set(sig, res)
    #p "#{sig}: #{res}"
    @cache[sig] = res
  end

  def get(sig)
    @cache[sig]
  end

  def size
    @cache.size
  end
end

class DeterministicDice
  def initialize
    @dice = (1..100).to_a.cycle
  end

  def roll
    r = 3.times.map { @dice.next }
    p "Rolling #{r}"
    [r.sum]
  end
end

class DiracDice
  THREE =
    [1, 2, 3].map do |a|
      [1, 2, 3].map do |b|
        [1, 2, 3].map do |c|
          a + b + c
        end
      end
    end.flatten

  TWO =
    [1, 2].map do |a|
      [1, 2].map do |b|
        a + b
      end
    end.flatten

  def roll
    THREE
  end
end

class Game
  def initialize(p1, p2, s1, s2)
    @p1 = p1
    @p2 = p2
    @s1 = s1
    @s2 = s2
  end

  def advance
    DICE.roll.map do |d1|
      DICE.roll.map do |d2|
        np1 = move @p1, d1
        np2 = move @p2, d2
        ns1 = @s1 + np1
        ns2 = @s2 + np2

        g = Game.new np1, np2, ns1, ns2
        #p "FROM: #{self} BY #{d1}, #{d2} TO: #{g}"
        g
      end
    end.flatten
  end

  def winner_stat
    if CACHE.get(sig)
      CACHE.hit
      return CACHE.get(sig)
    end

    CACHE.inc

    result =
      if @s1 >= FINISH
        {first: 1}
      elsif @s2 >= FINISH
        {second: 1}
      else
        advance.reduce({}) { |m, c| m.merge(c.winner_stat) { |k, o, n| o + n }}
      end

    CACHE.set(sig, result)
    #p "WINNERS: #{self}: #{result}"
    result
  end

  def move(p, d)
    (p + d).then { _1 > 10 ? _1 % 10 : _1}.then { _1 == 0 ? 10 : _1 }
  end

  def to_s
    "P1 at #{@p1}(#{@s1}), P2 at #{@p2}(#{@s2})"
  end

  def sig
    [@p1, @p2, @s1, @s2].join
  end
end

FINISH = 21
DICE = DiracDice.new
CACHE = Cache.new

input = (STDIN.tty? ? DATA : STDIN).readlines(chomp: true)
p1, p2 = input.map { _1.split(': ')[1].to_i }

current = Game.new p1, p2, 0, 0
a = current.winner_stat
p a
p a.values.max

p 'cache'
p CACHE.iterations
p CACHE.hits
p CACHE.size

__END__
Player 1 starting position: 4
Player 2 starting position: 8
