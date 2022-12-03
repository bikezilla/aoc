#!ruby

input = (STDIN.tty? ? DATA : STDIN).readlines(chomp: true)

input.
  then { p _1}

__END__
SMALL
INPUT
GOES
HERE
