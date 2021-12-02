import * as fs from 'fs';

const input = fs.readFileSync('../input/01.txt').toString().split('\n').map((e) => Number(e))

const increases = (input: number[]): number => {  
    return input.reduce((memo, element, index) => memo + (index == 0 ? 0 : element > input[index-1] ? 1 : 0), 0)
}

const threeMeasureSliding = (input: number[]): number => {
    return increases(input.slice(0, input.length - 2).map((v, i) => v + input[i+1] + input[i+2]))
}

console.log(increases(input))
console.log(threeMeasureSliding(input))




