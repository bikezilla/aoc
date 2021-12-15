def display(what = :distance)
  system `clear`
  data = what == :distance ? @distances : @values
  data.each do |line|
    line.each { printf '%4s', _1 == Float::INFINITY ? '∞' : _1 }
    print "\n"
  end
end

def adjacent(x, y)
  [
    [x + 1, y],
    [x, y + 1],
    [x - 1, y],
    [x, y - 1],
  ].select { _1 >= 0 && _2 >= 0 && _1 < @max_x && _2 < @max_y }
end

def visit(x, y)
  adjacent(x, y).map do |ax, ay|
    new_distance = @distances[y][x] + @values[ay][ax]

    if new_distance < @distances[ay][ax]
      @distances[ay][ax] = new_distance

      @to_visit[new_distance] ||= []
      @to_visit[new_distance] << [ax, ay]
    end
  end
end

def choose_next
  chosen, index = nil, nil

  @to_visit.each.with_index do |pairs, i|
    if pairs
      chosen = pairs
      index = i
      break
    end
  end

  if chosen.one?
    @to_visit[index] = nil
    chosen.first
  else
    chosen.shift
  end
end

@values = (STDIN.tty? ? DATA : STDIN).readlines(chomp: true).map { |line| line.split('').map(&:to_i) }

@values = @values.map do |line|
  multiplied = []
  5.times do |n|
    multiplied += line.map do |value|
      a = value + n
      a > 9 ? a - 9 : a
    end
  end
  multiplied
end

lines = @values.size
(1..4).each do |n|
  lines.times do |y|
    @values << @values[y].map do |value|
      a = value + n
      a > 9 ? a - 9 : a
    end
  end
end

#display :values

@max_y = @values.size
@max_x = @values.first.size
@distances = @values.map { _1.map { Float::INFINITY } }
@distances[0][0] = 0
@to_visit = [[[0, 0]]]

loop do
  x, y = choose_next

  break if x == @max_x - 1 && y == @max_y - 1

  visit x, y
  #display
end

p @distances.last.last

__END__
1163751742
1381373672
2136511328
3694931569
7463417111
1319128137
1359912421
3125421639
1293138521
2311944581
