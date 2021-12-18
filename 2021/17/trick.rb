require 'pastel'

Point = Struct.new :x, :y

def display(path = [], x, y)
  pastel = Pastel.new

  system 'clear'
  p "#{x}, #{y}"

  x_axis = 0.upto [@target_x.max, path.last&.x].compact.max
  y_axis = [0, path.map(&:y).max].compact.max.downto @target_y.min

  y_axis.each do |y|
    x_axis.each do |x|
      if x == 0 && y == 0
        print pastel.bright_yellow.bold('S')
      elsif path.include? Point.new x, y
        print pastel.bright_yellow.bold('#')
      elsif @target_x.include?(x) && @target_y.include?(y)
        print 'T'
      else
        print '.'
      end
    end
    print "\n"
  end

  gets
end

def trajectory(velocity_x, velocity_y)
  path = [Point.new(0, 0)]

  while path.last.x < @target_x.max && path.last.y > @target_y.min do
    path << Point.new(path.last.x + velocity_x, path.last.y + velocity_y)

    velocity_x = velocity_x == 0 ? 0 : velocity_x > 0 ? velocity_x - 1 : velocity_x + 1
    velocity_y = velocity_y - 1
  end

  path
end

(STDIN.tty? ? DATA : STDIN).read.then do |line|
  spec_x, spec_y = line.delete('target area: ').split(',')
  @target_x = eval spec_x.delete('x=')
  @target_y = eval spec_y.delete('y=')
end

# Min X velocity - the sum of steps on X must be at least the minimum X of the target area,
# thus, the triangular root of the minimum X of the target area is as low as we should start.
# Max X velocity - anywhere more than the max X of the target will shoot past on first step
min_xv = (Math.sqrt(8 * @target_x.min + 1) - 1).round / 2
max_xv = @target_x.max

# Min Y velocity - any Y velocity lower than the lowest target Y will shoot below target on first step.
# Max Y velocity - when falling the probe always reaches 0 with a velocity of exactly `-(initial_y + 1)`,
# thus anything more than this will make it shoot past the target area on first fall below 0
min_yv = @target_y.min
max_yv = - min_yv

paths = {}

min_xv.upto(max_xv).each do |x|
  min_yv.upto(max_yv).each do |y|
    path = trajectory x, y
    paths[[x,y]] = path if path.any? { @target_x.include?(_1.x) && @target_y.include?(_1.y) }

    display path, x, y
  end
end

p paths.size
max, path = paths.max_by { _2.flatten.map(&:y).max }
p max
p path.map(&:y).max

__END__
target area: x=20..30, y=-10..-5

