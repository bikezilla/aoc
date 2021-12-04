import * as fs from 'fs';

const input = fs.readFileSync('../input/03.txt').toString().split('\n')

const count = (line: string[], value: '1' | '0'): number => {
    return line.filter(c => c == value).length
}

const gamma = (matrix: string[][]): number => {
    const binary = matrix.map((line) => count(line, '1') > count(line, '0') ? '1' : '0').join('')

    return parseInt(binary, 2)
}

const epsilon = (matrix: string[][]): number => {
    const binary = matrix.map((line) => count(line, '1') < count(line, '0') ? '1' : '0').join('')

    return parseInt(binary, 2)
}

const consumption = (input: string[]): number => {
    const transposed = input[0].split('').map((col, i) => input.map((row) => row[i]))
    
    return gamma(transposed) * epsilon(transposed)
}

const oxygen = (input: string[], index: number = 0): string => {
    if (input.length == 1) {
        return input[0]
    } else {
        const ones = input.filter(v => v[index] == '1')
        const zeros = input.filter(v => v[index] == '0')

        return ones.length >= zeros.length ? oxygen(ones, index + 1) : oxygen(zeros, index + 1)
    }
}

const co2 = (input: string[], index: number = 0): string => {    
    if (input.length == 1) {
        return input[0]
    } else {
        const ones = input.filter(v => v[index] == '1')
        const zeros = input.filter(v => v[index] == '0')        

        return ones.length < zeros.length ? co2(ones, index + 1) : co2(zeros, index + 1)
    }
}

const lifeSupport = (input: string[]) : number => {
    return parseInt(oxygen(input), 2) * parseInt(co2(input), 2)
}

console.log(consumption(input))
console.log(lifeSupport(input))

