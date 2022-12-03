#!ruby

input = (STDIN.tty? ? DATA : STDIN).readlines(chomp: true)
input = DATA.readlines(chomp: true) if input.size == 0

input.
  then { p _1}

__END__
SMALL
INPUT
GOES
HERE
