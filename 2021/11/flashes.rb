input = (STDIN.tty? ? DATA : STDIN).readlines(chomp: true).map { _1.chars.map(&:to_i) }

N = 10

def neighbours(x, y)
  [
    [x, y - 1],
    [x + 1, y - 1],
    [x + 1, y],
    [x + 1, y + 1],
    [x, y + 1],
    [x - 1, y + 1],
    [x - 1, y],
    [x - 1, y -1],
  ].select { |tuple| tuple.all? { _1 >= 0 && _1 < N } }
end

def step(input)
  result =
    input.map.with_index do |row, y|
      row.map.with_index do |e, x|
        e + 1
      end
    end

  flashed = {}

  loop do
    collateral = []

    result.map.with_index do |row, y|
      row.map.with_index do |e, x|
        next if e <= 9 || flashed[[x, y]]

        result[y][x] = 0
        flashed[[x, y]] = true
        collateral += neighbours x, y
      end
    end

    break if collateral.empty?

    collateral.each { |x, y| result[y][x] += 1 unless flashed[[x, y]] }
  end

  [result, flashed.size]
end

total = 0
index = 0

loop do
  index += 1
  input, new_flashes = step(input)
  total += new_flashes
  break if input.flatten.all?(&:zero?)
end

pp input
pp total
pp index

__END__
5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526
