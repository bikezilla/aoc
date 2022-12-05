#!ruby

input = (STDIN.tty? ? DATA : STDIN).readlines(chomp: true)
input = DATA.readlines(chomp: true) if input.size == 0

input.
  map { |line| line.split(',').map { (_1.split('-')[0].to_i)..(_1.split('-')[1].to_i) } }.
  count { |left, right| left.cover?(right) || right.cover?(left) }.
  then { puts _1 }

input.
  map { |line| line.split(',').map { (_1.split('-')[0].to_i)..(_1.split('-')[1].to_i) } }.
  count do |left, right|
    left.include?(right.begin) ||
      left.include?(right.end) ||
      right.include?(left.begin) ||
      right.include?(left.end)
  end.
  then { puts _1 }

__END__
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8
