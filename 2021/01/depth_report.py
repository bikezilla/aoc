def read_input():
    return list(map(lambda i: int(i), open('../input/01.txt', 'r').read().split()))

def increases(input):
    result = 0
    for a, b in zip(input, input[1:]):
        if a < b: result += 1
    return result

def three_m_sliding_increases(input):
    windows = [sum(input[i:i+3]) for i in range(0, len(input)-2)]
    return increases(windows)

def main():
    input = read_input()
    print increases(input)
    print three_m_sliding_increases(input)

if __name__ == "__main__":
    main()

