import * as fs from 'fs'
import * as _ from 'lodash'

const input = fs.readFileSync('input/07.txt').toString().split(',').map(x => parseInt(x))

function fuel(x: number, x1: number): number {
    return Math.abs(x - x1)
}

function fuel2(x: number, x1: number): number {
    const distance = Math.abs(x - x1)
    const [max, rem] = distance % 2 == 0 ? [distance, 0] : [distance - 1, distance]

    return (1 + max) * Math.floor(distance / 2) + rem

}

function minimum(input: number[], fuel: (x: number, x1: number) => number): number {
    const sorted = input.sort()
    const min = sorted[0]
    const max = sorted.slice(-1)[0]

    return _.range(min, max).map(position => input.map(x => fuel(position, x)).reduce((m, x) => m + x)).sort()[0]
}


console.log(minimum(input, fuel))

console.log(minimum(input, fuel2))

console.log(fuel2(5,16))
console.log(fuel2(2,5))
console.log(fuel2(1,5))
