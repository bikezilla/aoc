#!ruby

def display(*things)
  things.respond_to?(:each) ? things.each { p _1 } : p(things)

  things
end

input = (STDIN.tty? ? DATA : STDIN).readlines(chomp: true)
input = DATA.readlines(chomp: true) if input.size == 0

class Number
  attr_reader :value, :adjacent_stars

  def initialize(value:, min_x:, y:, input:)
    @value = value
    @min_x = min_x
    @y = y

    @adjacent_stars = []

    @part_number =
      ((min_x - 1)..(min_x + value.size)).any? do |ax|
        ((y - 1)..(y + 1)).any? do |ay|
          target = (input[ay] || [])[ax]

          @adjacent_stars << [ax, ay] if target == '*'

          target && !target.match(/\d/) && target != '.'
        end
      end
  end

  def part_number? = @part_number
  def adjacent_star = @adjacent_stars.first # the input does not have numbers with two adj stars
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
  select { _1.part_number? && _1.adjacent_star }.
  group_by(&:adjacent_star).
  select { _2.size === 2 }.
  map { _2.map(&:value).map(&:to_i).reduce(:*) }.
  sum.
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
