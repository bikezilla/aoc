#!ruby

input = (STDIN.tty? ? DATA : STDIN).readlines(chomp: true)
input = DATA.readlines(chomp: true) if input.size == 0

sums = []
current_sum = 0

input.
  each do |calories|
    if calories.size != 0
      current_sum += calories.to_i
    else
      sums << current_sum
      current_sum = 0
    end
  end

p sums.max
p sums.sort.last(3).sum

__END__
1000
2000
3000

4000

5000
6000

7000
8000
9000

10000

