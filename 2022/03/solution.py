#!python

import sys
from functools import reduce

EXAMPLE = """
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
"""

input = EXAMPLE.splitlines()[1:] if sys.stdin.isatty() else sys.stdin.read().splitlines()
if len(input) == 0: input = input = EXAMPLE.splitlines()[1:]

def priority(char):
    if char < 'a':
        result = ord(char) - 38
    else:
        result = ord(char) - 96

    return result

result = [set(r[:len(r) // 2]) & set(r[len(r) // 2:]) for r in input]
result = map(lambda x: list(map(priority, x)), result)
result = sum(map(lambda x: sum(x), result))
print(result)

result = [input[i:i+3] for i in range(0, len(input), 3)]
result = map(lambda x: reduce(lambda a,b: set(a) & set(b), x), result)
result = map(lambda x: list(map(priority, x)), result)
result = sum(map(lambda x: sum(x), result))
print(result)


