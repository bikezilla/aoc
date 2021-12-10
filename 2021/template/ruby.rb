input = (STDIN.tty? ? DATA : STDIN).readlines(chomp: true)

input.
  then { p _1}

__END__
input string
