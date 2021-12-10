def breed(input)
  new_born = input.count { _1 == 0 }

  input.map { _1 == 0 ? 6 : _1 - 1 } + Array.new(new_born, 8)
end

def breed2(fish_map)
  new_born = fish_map[0]
  fish_map = fish_map[1..]
  fish_map[6] += new_born
  fish_map[8] = new_born
  fish_map
end

input = (STDIN.tty? ? DATA : STDIN).read.split(',').map(&:to_i)

input1 = input.dup
80.times { input1 = breed(input1) }
p input1.size

fish_map = input.each_with_object(Array.new(9, 0)) { |c, map| map[c] +=1 }
256.times { fish_map = breed2(fish_map) }
p fish_map.sum

__END__
3,4,3,1,2
