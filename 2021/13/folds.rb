Instruction = Struct.new :axis, :index

def print(dots)
  dots.each do |line|
    p line.map { _1 ? '#' : ' ' }.join
  end
end

def fold(dots, fold_axis, fold_index)
  max_x = dots.compact.map(&:size).max
  max_y = dots.size
  result = Array.new(max_y).map { Array.new max_x }

  if fold_axis == 'y'
    (0...fold_index).each do |y|
      mirror_line = dots[fold_index * 2 - y] || []

      (0...max_x).each do |x|
        result[y][x] = dots[y][x] || mirror_line[x]
      end
    end

    result[0, fold_index]
  else
    (0...max_y).each do |y|
      (0...fold_index).each do |x|
        result[y][x] = dots[y][x] || dots[y][fold_index * 2 - x]
      end
    end

    result.map { _1[0, fold_index] }
  end
end

dots_input, instructions_input = (STDIN.tty? ? DATA : STDIN).read.split("\n\n").map { _1.split("\n") }

dots_input = dots_input.map { _1.split(',').map(&:to_i) }
size_x = dots_input.map { _1[0] }.max + 1
size_y = dots_input.map { _1[1] }.max + 1

dots =
  dots_input.reduce(Array.new(size_y).map { Array.new size_x }) do |result, (x, y)|
    result[y][x] = true
    result
  end

instructions =
  instructions_input.map do |line|
    axis, index = line.split(' ').last.split('=')
    Instruction.new axis, index.to_i
  end

instructions.each do |instruction|
  dots = fold dots, instruction.axis, instruction.index
end

print dots

__END__
6,10
0,14
9,10
0,3
10,4
4,11
6,0
6,12
4,1
0,13
10,12
3,4
3,0
8,4
1,10
2,14
8,10
9,0

fold along y=7
fold along x=5
