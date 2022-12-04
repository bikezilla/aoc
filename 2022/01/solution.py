#!python

import sys

EXAMPLE = """
1000
2000
3000

4000

5000
6000

7000
8000
9000

10000
"""

input = EXAMPLE.splitlines()[1:] if sys.stdin.isatty() else sys.stdin.read().splitlines()
if len(input) == 0: input = input = EXAMPLE.splitlines()[1:]

sums = []
current_sum = 0

for calories in input:
    if len(calories) != 0:
        current_sum += int(calories)
    else:
        sums.append(current_sum)
        current_sum = 0
sums.append(current_sum)

sums.sort(reverse=True)

print(sums[0])
print(sum(sums[0:3]))

