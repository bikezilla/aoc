def navigate(input)
  reduced = input.each_slice(2).each_with_object(Hash.new(0)) { |(k, v), m| m[k] += v }

  reduced['forward'] * (reduced['down'] - reduced['up'])
end

def navigate2(input)
  position, depth, aim = 0, 0, 0

  input.each_slice(2) do |(cmd, v)|
    case cmd
    when 'forward'
      position += v
      depth += v * aim
    when 'down'
      aim += v
    when 'up'
      aim -= v
    end
  end

  position * depth
end

input = File.read('../input/02.txt').split().map.with_index { |e, i| i.odd? ? e.to_i : e }

p navigate(input)
p navigate2(input)
