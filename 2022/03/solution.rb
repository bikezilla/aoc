#!ruby

input = (STDIN.tty? ? DATA : STDIN).readlines(chomp: true)

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
  then { p _1}

input.
  each_slice(3).map do |slice|
    slice[0].chars & slice[1].chars & slice[2].chars
  end.
  flatten.
  map { _1.ord -  (_1 < 'a' ? 38 : 96) }.
  sum.
  then { p _1}

__END__
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
