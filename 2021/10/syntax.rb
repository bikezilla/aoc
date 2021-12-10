input = (STDIN.tty? ? DATA : STDIN).readlines(chomp: true)

BRACKETS = {
  '(' => ')',
  '[' => ']',
  '{' => '}',
  '<' => '>',
}

ERROR_SCORES = {
  ')' => 3,
  ']' => 57,
  '}' => 1197,
  '>' => 25137,
}

COMPLETION_SCORES = {
  ')' => 1,
  ']' => 2,
  '}' => 3,
  '>' => 4,
}

def corrupted_char(line)
  line.chars.each.with_object([]) do |c, lookup|
    if c == lookup.first
      lookup.shift
    elsif BRACKETS.keys.include? c
      lookup.prepend BRACKETS[c]
    else
      return c
    end
  end

  nil
end

def completion_string(line)
  line.chars.each.with_object([]) do |c, lookup|
    c == lookup.first ? lookup.shift : lookup.prepend(BRACKETS[c])
  end
end

def completion_score(s)
  s.reduce(0) { |m, c| (m * 5) + COMPLETION_SCORES[c] }
end

input.
  map { corrupted_char _1 }.
  compact.
  tally.
  sum { |k, v| v * ERROR_SCORES[k] }.
  then { p _1 }

input.
  reject { corrupted_char _1 }.
  map { completion_string _1 }.
  map { completion_score _1 }.
  sort.
  then { p _1[_1.size / 2] }

__END__
[({(<(())[]>[[{[]{<()<>>
[(()[<>])]({[<{<<[]>>(
{([(<{}[<>[]}>{[]{[(<()>
(((({<>}<{<{<>}{[]{[]{}
[[<[([]))<([[{}[[()]]]
[{[{({}]{}}([{[{{{}}([]
{<[[]]>}<{[{[{[]{()[[[]
[<(<(<(<{}))><([]([]()
<{([([[(<>()){}]>(<<{{
<{([{{}}[<[[[<>{}]]]>[]]
