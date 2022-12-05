#!ruby

input = (STDIN.tty? ? DATA : STDIN).read
input = DATA.read if input.size == 0

def display(command, crates, width)
  puts '=' * width
  puts command
  puts '=' * width
  crates.each { puts _1.join }
end

drawing, procedure = input.split("\n\n").map { _1.split("\n") }

width = drawing.first.size
crates =
  drawing.
  map { |line| line.chars.values_at(*(1...width).step(4).to_a) }.
  transpose.
  map(&:reverse).
  map { |line| line.reject { _1 == ' ' }}

procedure.each do |command|
  count, from, to = command.scan(/\d+/)
  # FIRST PART: count.to_i.times { crates[to.to_i - 1].push crates[from.to_i - 1].pop }
  crates[to.to_i - 1].push(*crates[from.to_i - 1].pop(count.to_i))
end

puts crates.map(&:last).join

__END__
    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3 

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
