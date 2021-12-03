def read_input():
    with open('../input/01.txt') as f:
        return [int(line) for line in f.read().split()]

def increases(input):
    return sum(1 for a,b in zip(input, input[1:]) if a < b)

def three_m_sliding_increases(input):
    windows = [sum(input[i:i+3]) for i in range(0, len(input)-2)]
    return increases(windows)

def main():
    input = read_input()
    print(increases(input))
    print(three_m_sliding_increases(input))

if __name__ == "__main__":
    main()

