template, insertions_input = (STDIN.tty? ? DATA : STDIN).read.split("\n\n").map { _1.split("\n") }

template = template.first
@insertions = insertions_input.map { _1.split(' -> ') }.to_h

counts = Hash.new(0).merge template.chars.tally
MAX_STEP = 40
@cache = {}
@total_iterations = 0
@cache_hits = 0

def increment(left, right, step = 0)
  @total_iterations += 1
  if @cache[[left, right, step]]
    @cache_hits += 1
    return @cache[[left, right, step]]
  end

  insert = @insertions[left + right]

  return {} unless insert

  counts = Hash.new(0)
  counts[insert] += 1

  if step + 1 < MAX_STEP
    counts.merge!(increment left, insert, step + 1) { _2 + _3 }
    counts.merge!(increment insert, right, step + 1) { _2 + _3 }
  end

  @cache[[left, right, step]] = counts
  return counts
end

template.chars.each_cons(2) do |left, right|
  counts.merge!(increment left, right) { _2 + _3 }
end

p counts
p @total_iterations
p @cache.size
p @cache_hits
p counts.values.then { _1.max - _1.min }

__END__
NNCB

CH -> B
HH -> N
CB -> H
NH -> C
HB -> C
HC -> B
HN -> C
NN -> C
BH -> H
NC -> B
NB -> B
BN -> B
BB -> N
BC -> B
CC -> N
CN -> C
