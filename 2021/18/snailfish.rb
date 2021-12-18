require 'pry'
module Snailfish
  extend self

  class Node
    attr_accessor :left, :right, :value

    def initialize(left, right, value = nil)
      @left = left
      @right = right
      @value = value
    end

    def leaf?
      !!@value
    end

    def to_s
      @value ? "(#{@value})" : "()"
    end

    def ==(rhs)
      rhs.is_a?(Node) && @left == rhs.left && @right == rhs.right && @value == rhs.value
    end

    def +(rhs)
      new_number = Node.new self.dup, rhs.dup
      Snailfish::Reducer.new(new_number).reduce
      new_number
    end

    def height
      [@left ? @left.height + 1 : 1, @right ? @right.height + 1 : 1].max
    end

    def width
      @value ? 1 : @left.width + @right.width
    end

    def split
      if !@value
        left.split
        right.split
      elsif @value > 10
        @left = Node.new nil, nil, (@value / 2.0).floor
        @right = Node.new nil, nil, (@value / 2.0).ceil
        @value = 0
      end
    end

    def magnitude
      @value ? @value : @left.magnitude * 3 + @right.magnitude * 2
    end

    def dup
      Node.new @left.dup, @right.dup, @value
    end
  end

  class Reducer
    def initialize(root)
      @root = root
      @right_add = nil
      @visited = []
      @dirty = true
      @exploded = false
    end

    def reduce
      while @dirty do
        begin
          explode(@root)
          split(@root)
          @dirty = false
        rescue StopIteration
          @right_add = nil
          @visited = []
          @exploded = false
        end
      end
    end

    def explode(node, level = 0)
      @visited << node

      if !@exploded && level >= 4 && node.left&.leaf? && node.right&.leaf?
        @visited.select(&:leaf?).last&.value += node.left.value
        @right_add = node.right.value
        @exploded = true

        node.left = nil
        node.right = nil
        node.value = 0
      elsif @right_add && node.leaf?
        node.value += @right_add
        raise StopIteration
      end

      explode(node.left, level + 1) if node.left
      explode(node.right, level + 1) if node.right
    end

    def split(node)
      if node.leaf? && node.value > 9
        node.left = Node.new nil, nil, (node.value / 2.0).floor
        node.right = Node.new nil, nil, (node.value / 2.0).ceil
        node.value = nil
        raise StopIteration
      else
        split(node.left) if node.left
        split(node.right) if node.right
      end
    end
  end

  def print_level(root, level)
    if level == 1
      base = Math.log(root.width, 2)
      padding = ' ' * (2 ** base + 2 ** (base - 1) - 1)
      print padding + root.to_s + padding
    else
      print_level(root.left, level - 1) if root.left
      print_level(root.right, level - 1) if root.right
      print ' '
    end
  end

  def print_root(root)
    height = root.height
    p root.width

    1.upto(height) do |level|
      print "#{level}: "
      print_level(root, level)
      print "\n"
    end
  end

  def parse(input)
    input.split("\n").map do |line|
      parse_string(line)
    end
  end

  def parse_string(line)
    if line.match /^\[\d,\d\]$/
      Node.new *line.scan(/\d/).map { Node.new nil, nil, _1.to_i }
    elsif line.match /\[|\]/
      brackets = 0

      left = line.chars[1..].take_while do |c|
        if c == '['
          brackets += 1
          true
        elsif c == ']'
          brackets -= 1
          true
        elsif c == ','
          brackets.nonzero?
        else
          true
        end
      end.join
      right = line[left.size+2..-2]

      Node.new left.match(/^\d+$/) ? Node.new(nil, nil, left.to_i) : parse_string(left),
               right.match(/^\d+$/) ? Node.new(nil, nil, right.to_i) : parse_string(right)
    end
  end
end

if Object.const_defined?('DATA')
  input = (STDIN.tty? ? DATA : STDIN).read

  numbers = Snailfish.parse(input)

  result = numbers.first
  numbers[1..].each do |number|
    result += number
  end
  Snailfish.print_root result
  p result.magnitude

  p numbers.permutation(2).map { _1 + _2}.map(&:magnitude).max
end

__END__
[[[0,[5,8]],[[1,7],[9,6]]],[[4,[1,2]],[[1,4],2]]]
[[[5,[2,8]],4],[5,[[9,9],0]]]
[6,[[[6,2],[5,6]],[[7,6],[4,7]]]]
[[[6,[0,7]],[0,9]],[4,[9,[9,0]]]]
[[[7,[6,4]],[3,[1,3]]],[[[5,5],1],9]]
[[6,[[7,3],[3,2]]],[[[3,8],[5,7]],4]]
[[[[5,4],[7,7]],8],[[8,3],8]]
[[9,3],[[9,9],[6,[4,9]]]]
[[2,[[7,7],7]],[[5,8],[[9,3],[0,2]]]]
[[[[5,2],5],[8,[3,7]]],[[5,[7,5]],[4,4]]]
