#!ruby

def display(thing)
  thing.respond_to?(:each) ? thing.each { p _1 } : p(thing)
end

input = (STDIN.tty? ? DATA : STDIN).readlines(chomp: true)
input = DATA.readlines(chomp: true) if input.size == 0

RED = 12
GREEN = 13
BLUE = 14

input.
  map { _1.split(':') }.
  to_h.
  transform_keys { _1.gsub('Game ', '').to_i }.
  transform_values do |game|
    game.
      split('; ').
      map do |reveal|
        reveal.split(', ').map { _1.split(' ').reverse }.to_h.transform_values(&:to_i)
      end.reduce({}) { |acc, r| acc.merge(r) { |_, old, new| [old, new].max } }
  end.
  values.map { _1.values.reduce(:*) }.
  sum.
  then { display _1 }

__END__
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
