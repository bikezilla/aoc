#!ruby

input = (STDIN.tty? ? DATA : STDIN).readlines(chomp: true)
input = DATA.readlines(chomp: true) if input.size == 0

input.
  map do |rucksack|
    middle = rucksack.size / 2
    left = rucksack[...middle]
    right = rucksack[middle..]

    left.chars & right.chars
  end.
  flatten.
  map { _1.ord -  (_1 < 'a' ? 38 : 96) }.
  sum.
  then { puts _1 }

input.
  each_slice(3).
  map { _1.chars & _2.chars & _3.chars }.
  flatten.
  map { _1.ord -  (_1 < 'a' ? 38 : 96) }.
  sum.
  then { puts _1 }

__END__
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
