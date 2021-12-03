def read_input():
    with open('../input/02.txt') as f:
        input = f.read().split()
        return [(input[i], int(input[i+1])) for i in range(0, len(input), 2)]

def navigate(input):
    position, depth = 0, 0
    for cmd, v in input:
        if cmd == 'forward':
            position += v
        elif cmd == 'down':
            depth += v
        elif cmd == 'up':
            depth -= v
    return position * depth

def navigate2(input):
    position, depth, aim = 0, 0, 0
    for cmd, v in input:
        if cmd == 'forward':
            position += v
            depth += v * aim
        elif cmd == 'down':
            aim += v
        elif cmd == 'up':
            aim -= v
    return position * depth

def main():
    input = read_input()
    print(navigate(input))
    print(navigate2(input))

if __name__ == "__main__":
    main()
