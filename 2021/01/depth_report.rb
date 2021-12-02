def increases(input)
  input.each_cons(2).reduce(0) { |m, (a, b)| a < b ? m + 1 : m }
end

def increases_three_m_sliding(input)
  increases input.each_cons(3).map(&:sum)
end

input = File.read('../input/01.txt').split.map(&:to_i)

p increases(input)
p increases_three_m_sliding(input)
