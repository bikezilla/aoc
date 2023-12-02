#!ruby

def display(thing)
  thing.respond_to?(:each) ? thing.each { p _1 } : p(thing)
end

input = (STDIN.tty? ? DATA : STDIN).readlines(chomp: true)
input = DATA.readlines(chomp: true) if input.size == 0

input.
  then { display _1 }

__END__
SMALL
INPUT
GOES
HERE
