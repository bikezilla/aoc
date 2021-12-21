PADDING = 2

def display(image)
  puts '-' * 20
  image.compact.each do |line|
    line.compact.each do |pixel|
      print pixel == 1 ? '#' : '.'
    end
    print "\n"
  end
end

def pad(image, infinity)
  result = PADDING.times.map { Array.new PADDING + image.first.size + PADDING, infinity }
  image.each do |line|
    result << Array.new(PADDING, infinity) + line + Array.new(PADDING, infinity)
  end
  result += PADDING.times.map { Array.new PADDING + image.first.size + PADDING, infinity }
  result
end

def neighbours(x, y)
  [
    [x - 1, y - 1],
    [x, y - 1],
    [x + 1, y - 1],
    [x - 1, y],
    [x, y],
    [x + 1, y],
    [x - 1, y + 1],
    [x, y + 1],
    [x + 1, y + 1]
  ]
end

def enhance(image, mask)
  1.upto(image.size - 2).map do |y|
    1.upto(image.first.size - 2).map do |x|
      index = neighbours(x, y).map { |x1, y1| image[y1][x1] }.join.to_i(2)
      mask[index] == '#' ? 1 : 0
    end
  end
end

mask, image = (STDIN.tty? ? DATA : STDIN).read.split("\n\n")

mask = mask.split("\n").join
image = image.split("\n").map { |line| line.chars.map { _1 == '#' ? 1 : 0 } }

infinity = 0

50.times do
  image = enhance pad(image, infinity), mask

  infinity = (infinity == 0 ? mask[0] : mask[511]).then { _1 == '#' ? 1 : 0 }
  display image
  gets
end

p image.flatten.count { _1 == 1 }

__END__
#.#.#..#####.#.#.#.###.##.....###.##.#..###.####..#####..#....#..#..##..##
#..######.###...####..#..#####..##..#.#####...##.#.#..#.##..#.#......#.###
.######.###.####...#.##.##..#..#..#####.....#.#....###..#.##......#.....#.
.#..#..##..#...##.######.####.####.#.#...#.......#..#.#.#...####.##.#.....
.#..#...##.#.##..#...##.#.##..###.#......#.#.......#.#.#.####.###.##...#..
...####.#..#..#.##.#....##..#.####....##...##..#...#......#.#.......#.....
..##..####..#...#.#.#...##..#.#..###..#####........#..####......#..#

#..#.
#....
##..#
..#..
..###
