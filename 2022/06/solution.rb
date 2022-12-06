#!ruby

input = (STDIN.tty? ? DATA : STDIN).readlines(chomp: true)
input = DATA.readlines(chomp: true) if input.size == 0

PACKET_SIZE = 14

input.
  first.
  chars.
  each_cons(PACKET_SIZE).
  with_index do |cons, index|
    if cons.uniq.size == PACKET_SIZE
      p index + PACKET_SIZE
      exit
    end
  end

__END__
mjqjpqmgbljsphdztnvjfqwrcgsmlb
