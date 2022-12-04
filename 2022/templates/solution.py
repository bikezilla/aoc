#!python

import sys

EXAMPLE = """
SMALL
INPUT
GOES
HERE
"""

input = EXAMPLE.splitlines()[1:] if sys.stdin.isatty() else sys.stdin.read().splitlines()
if len(input) == 0: input = input = EXAMPLE.splitlines()[1:]

result = input

print(result)

