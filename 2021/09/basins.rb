require 'set'

def adjacent(x,y)
  [
    [x, (y-1).abs],
    [x+1, y],
    [x, y+1],
    [(x-1).abs, y]
  ].uniq.select { _1 < @max_x && _2 < @max_y }
end

def lows
  @terrain.each.with_index.reduce([]) do |m, (row, y)|
    row.each.with_index do |e, x|
      m << [x, y] if adjacent(x, y).all? { @terrain[_2][_1] > e }
    end
    m
  end
end

def basin_around(x, y, basin = Set.new)
  basin << [x, y]

  new_points = Set.new(adjacent(x, y).select { |x1, y1| @terrain[y1][x1] < 9 }) - basin

  if new_points.any?
    new_points.reduce(basin) { |m, (x1, y1)| m + basin_around(x1, y1, m) }
  else
    basin
  end
end

input = (STDIN.tty? ? DATA : STDIN).readlines(chomp: true)

@terrain = input.map { _1.chars.map(&:to_i) }
@max_y = @terrain.size
@max_x = @terrain.first.size

low_points = lows
pp low_points.map { @terrain[_2][_1].next }.sum
pp low_points.map { |x, y| basin_around(x, y).size }.sort.last(3).reduce(:*)

__END__
2199943210
3987894921
9856789892
8767896789
9899965678
