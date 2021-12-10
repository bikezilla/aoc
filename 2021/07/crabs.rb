def fuel(x, x1) = (x - x1).abs

def fuel2(x, x1)
  distance = (x - x1).abs
  max, rem = distance.even? ? [distance, 0] : [distance - 1, distance]

  (1 + max) * (distance / 2) + rem
end

input = (STDIN.tty? ? DATA : STDIN).read.split(',').map(&:to_i)

min, *_, max = input.sort

p (min..max).map { |target| input.map { fuel(_1, target) }.sum }.min
p (min..max).map { |target| input.map { fuel2(_1, target) }.sum }.min

__END__
16,1,2,0,4,2,7,1,2,14
