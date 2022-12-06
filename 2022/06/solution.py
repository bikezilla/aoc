#!python

import sys

EXAMPLE = """
mjqjpqmgbljsphdztnvjfqwrcgsmlb
"""

input = EXAMPLE.splitlines()[1:] if sys.stdin.isatty() else sys.stdin.read().splitlines()
if len(input) == 0: input = input = EXAMPLE.splitlines()[1:]

input = input[0]
PACKET_SIZE = 14

cons = [input[i:i+PACKET_SIZE] for i in range(len(input)-PACKET_SIZE+1)]
for i, con in enumerate(cons):
    if (len(set(con)) == PACKET_SIZE):
       print(i + PACKET_SIZE)
       break

