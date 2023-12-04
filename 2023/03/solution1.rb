#!ruby

def display(*things)
  things.respond_to?(:each) ? things.each { p _1 } : p(things)

  things
end

input = (STDIN.tty? ? DATA : STDIN).readlines(chomp: true)
input = DATA.readlines(chomp: true) if input.size == 0

class Number
  attr_reader :value

  def initialize(value:, min_x:, y:, input:)
    @value = value
    @min_x = min_x
    @y = y

    @part_number =
      ((min_x - 1)..(min_x + value.size)).any? do |ax|
        ((y - 1)..(y + 1)).any? do |ay|
          target = (input[ay] || [])[ax]

          target && !target.match(/\d/) && target != '.'
        end
      end
  end

  def part_number? = @part_number
end

input.
  flat_map.with_index do |line, y|
    offset = 0
    line.scan(/\d+/).map do |match|
      match_index = line.index(match, offset)
      offset = match_index + match.size

      Number.new value: match, min_x: match_index, y:, input:
    end
  end.
  select { _1.part_number? }.
  sum { _1.value.to_i }.
  tap { display _1 }


__END__
467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..
