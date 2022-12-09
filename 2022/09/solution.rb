#!ruby

input = (STDIN.tty? ? DATA : STDIN).readlines(chomp: true)
input = DATA.readlines(chomp: true) if input.size == 0

class Rope
  def initialize
    @hx = 0
    @hy = 0
    @tx = 0
    @ty = 0
  end

  def move_head(direction)
    case direction
    in 'R' then @hx += 1
    in 'L' then @hx -= 1
    in 'U' then @hy += 1
    in 'D' then @hy -=1
    end

    case
    when @hx == @tx && @hy - @ty == 2 then @ty += 1
    when @hx == @tx && @hy - @ty == -2 then @ty -= 1
    when @hy == @ty && @hx - @tx == 2 then @tx += 1
    when @hy == @ty && @hx - @tx == -2 then @tx -= 1
    end
  end

  def display
    max_y = @hy + 2
    max_x = @hx + 2

    puts '=' * (max_x + 1)
    max_y.downto(0) do |y|
      0.upto(max_x) do |x|
        case
        when y == @hy && x == @hx then print 'H'
        when y == @ty && x == @tx then print 'T'
        else print '.'
        end
      end
      puts "\n"
    end
  end
end

rope = Rope.new

input.
  each do |command|
    direction, count = command.split(' ')
    count.to_i.times do
      rope.move_head(direction)
      rope.display
    end
  end

__END__
R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2
