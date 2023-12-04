#!ruby

def display(args)
  args.respond_to?(:each) ? args.each { p _1 } : p(args)
end

input = (STDIN.tty? ? DATA : STDIN).readlines(chomp: true)
input = DATA.readlines(chomp: true) if input.size == 0

@counters = Array.new(input.size, 1)

@copies =
  input.
    map { _1.gsub(/Card\s+\d+:\s+/, '') }.
    map { _1.split(/\s+\|\s+/).map { |n| n.split(/\s+/).map(&:to_i) } }.
    map { (_1 & _2).size }

def count_copies(index)
  copies = @copies[index]

  return if copies == 0

  (1..copies).each do |offset|
    @counters[index + offset] +=1
    count_copies(index + offset)
  end
end

(0...@copies.size).each { count_copies _1 }

p @counters.sum

__END__
Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
