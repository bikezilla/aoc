#!ruby

input = (STDIN.tty? ? DATA : STDIN).readlines(chomp: true)
input = DATA.readlines(chomp: true) if input.size == 0

regex = /(?:zero|one|two|three|four|five|six|seven|eight|nine|ten|\d)/

replacements = {
  zero: 0,
  one: 1,
  two: 2,
  three: 3,
  four: 4,
  five: 5,
  six: 6,
  seven: 7,
  eight: 8,
  nine: 9,
}

result =
  input.map do |line|
    [line.index(regex), line.rindex(regex)].
      map { line[_1..-1].scan(regex).first }.
      map { replacements[_1.to_sym] || _1}.
      join.
      to_i
  end.sum

p result


__END__
1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet
