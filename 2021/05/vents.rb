Point = Struct.new :x, :y
Line = Struct.new :from, :to do
  def walk
    x_axis =
      if from.x == to.x
        Array.new (from.y - to.y).abs + 1, from.x
      elsif from.x < to.x
        from.x.upto to.x
      else
        from.x.downto to.x
      end

    y_axis =
      if from.y == to.y
        Array.new (from.x - to.x).abs + 1, from.y
      elsif from.y < to.y
        from.y.upto to.y
      else
        from.y.downto to.y
      end

    x_axis.zip(y_axis).each do |x, y|
      yield x, y
    end
  end

  def parallel_to_axes?
    from.x == to.x || from.y == to.y
  end
end

def read_input
  File.read('../input/05.txt').split("\n").map do |line|
    from_x, from_y, to_x, to_y = line.split('->').flat_map { _1.split(',').map(&:to_i) }

    Line.new Point.new(from_x, from_y), Point.new(to_x, to_y)
  end
end

def map_vents(lines)
  lines.each_with_object([]) do |line, map|
    line.walk do |x, y|
      map[y] ||= []
      map[y][x] = (map[y][x] || 0) + 1
    end
  end
end

def count_overlapping(map)
  map.flatten.compact.count { _1 > 1 }
end

def humanize(map)
  map.compact.map { |line| line.map { _1 ? _1 : '.' }.join }
end

input = read_input

p count_overlapping map_vents input.select(&:parallel_to_axes?)
p count_overlapping map_vents input
