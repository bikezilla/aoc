def read_input
  File.readlines('../input/03.txt').map(&:chomp)
end

def consumption(input)
  grouped = input.map(&:chars).transpose.map { |n| n.partition { _1 == '1' } }

  gamma = grouped.map { _1.max_by(&:size).first }.join.to_i(2)
  epsilon = grouped.map { _1.min_by(&:size).first }.join.to_i(2)

  gamma * epsilon
end

def oxygen(input, index = 0)
  if input.size == 1
    input.first
  else
    oxygen input.partition { _1[index] == '1' }.max_by(&:size), index + 1
  end
end

def co2(input, index = 0)
  if input.size == 1
    input.first
  else
    co2 input.partition { _1[index] == '0' }.min_by(&:size), index + 1
  end
end

input = read_input

p consumption(input)
p oxygen(input).to_i(2) * co2(input).to_i(2)

