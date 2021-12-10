def digit(pattern)
  case pattern
  when /^[abcefg]{6}$/ then 0
  when /^[cf]{2}$/ then 1
  when /^[acdeg]{5}$/ then 2
  when /^[acdfg]{5}$/ then 3
  when /^[bcdf]{4}$/ then 4
  when /^[abdfg]{5}$/ then 5
  when /^[abdefg]{6}$/ then 6
  when /^[acf]{3}$/ then 7
  when /^[abcdefg]{7}$/ then 8
  when /^[abcdfg]{6}$/ then 9
  else
    raise "Unknown pattern #{pattern}."
  end
end

def decipher(line)
  one = line.find { _1.size == 2 }.chars
  four = line.find { _1.size == 4 }.chars
  seven = line.find { _1.size == 3 }.chars
  eight = line.find { _1.size == 7 }.chars
  zero_six_nine = line.select { _1.size == 6 }.map(&:chars)
  two_three_five = line.select { _1.size == 5 }.map(&:chars)

  a = (seven - four).first
  g = zero_six_nine.map { _1 - seven - four }.reduce(:&).first
  e = two_three_five.map { _1 - four - seven - [g] }.flatten.first
  b = zero_six_nine.map { _1 - seven - [g, e] }.reduce(:&).first
  d = (four - one - [b]).first
  f = (zero_six_nine.reduce(:&) - [a, b, g]).first
  c = (eight - [a,b, d, e, f, g]).first

  {a => 'a', b => 'b', c => 'c', d => 'd', e => 'e', f => 'f', g => 'g'}
end

input = (STDIN.tty? ? DATA : STDIN).readlines(chomp: true)

input.map do |line|
  patterns, display = line.split(' | ').map { _1.split(' ') }
  transform = decipher patterns

  display.map { |number| number.gsub(/./) { transform[_1] } }.map { digit _1 }
end.map(&:join).map(&:to_i).sum.then { p _1 }

__END__
be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
