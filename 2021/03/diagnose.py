def read_input():
    with open('../input/03.txt') as f:
        return f.read().split()

def consumption(input):
    transposed = [list(row) for row in zip(*input)]
    gamma = ''.join(['1' if row.count('1') > row.count('0') else '0' for row in transposed])
    epsilon = ''.join(['1' if row.count('1') < row.count('0') else '0' for row in transposed])
    return int(gamma, 2) * int(epsilon, 2)

def oxygen(input, index = 0):
    if len(input) == 1:
        return input[0]
    else:
        ones = list(filter(lambda n: n[index] == '1', input))
        zeros = list(filter(lambda n: n[index] == '0', input))
        return oxygen(ones if len(ones) >= len(zeros) else zeros, index + 1)

def co2(input, index = 0):
    if (len(input) == 1):
        return input[0]
    else:
        ones = list(filter(lambda n: n[index] == '1', input))
        zeros = list(filter(lambda n: n[index] == '0', input))
        return co2(zeros if len(zeros) <= len(ones) else ones, index + 1)

def life_support(input):
    return int(oxygen(input), 2) * int(co2(input), 2)

def main():
    input = read_input()
    print(consumption(input))
    print(life_support(input))

if __name__ == "__main__":
    main()


