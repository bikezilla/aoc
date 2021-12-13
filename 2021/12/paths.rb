require 'set'

def visit(node, path_to_node, paths)
  current_path = path_to_node + [node]

  if node == 'end'
    paths << current_path
  else
    to_visit = @adjacent[node] - current_path.select { /^(start|[[:lower:]]+)$/.match _1 }

    to_visit.each { visit _1, current_path, paths }
  end
end

def visit2(node, path_to_node, paths)
  current_path = path_to_node + [node]

  if node == 'end'
    paths << current_path
  else
    filter =
      if current_path.select { /^[[:lower:]]+$/.match _1 }.tally.values.any? { _1 == 2 }
        /^(start|[[:lower:]]+)$/
      else
        /^start$/
      end

    to_visit = @adjacent[node] - current_path.select { filter.match _1 }

    to_visit.each { visit2 _1, current_path, paths }
  end
end

@adjacent = {}
@paths = []

input = (STDIN.tty? ? DATA : STDIN).readlines(chomp: true)

input.map do |line|
  from, to = line.split('-')

  @adjacent[from] ||= Set.new
  @adjacent[to] ||= Set.new
  @adjacent[from] << to
  @adjacent[to] << from
end

paths1 = []
visit('start', [], paths1)
p paths1.size

paths2 = []
visit2('start', [], paths2)
p paths2.size

__END__
fs-end
he-DX
fs-he
start-DX
pj-DX
end-zg
zg-sl
zg-pj
pj-he
RW-he
fs-DX
pj-RW
zg-RW
start-pj
he-WI
zg-he
pj-fs
start-RW
