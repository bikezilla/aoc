import * as fs from 'fs';

type Instruction = {
    command: 'forward' | 'down' | 'up'
    value: number
}

const input = fs.readFileSync('../input/02.txt').toString().split('\n').map(line => {
    const [command, value] = line.split(' ')
    return {command, value: parseInt(value)} as unknown as Instruction
})

function navigate(input: Instruction[]): number {
    const forward = input.filter(e => e.command == 'forward').reduce((m, e) => m + e.value, 0)
    const up = input.filter(e => e.command == 'up').reduce((m, e) => m + e.value, 0)
    const down = input.filter(e => e.command == 'down').reduce((m, e) => m + e.value, 0)

    return forward * (down - up)
}

function navigate2(input: Instruction[]): number {
    const reduced = input.reduce((m, e) => {        
        switch (e.command) {
            case 'forward':
                return {...m, position: m.position + e.value, depth: m.depth + m.aim * e.value}
            case 'down':
                return {...m, aim: m.aim + e.value}
            case 'up':
                return {...m, aim: m.aim - e.value}
            default:
                return m
        }
    }, {position: 0, depth: 0, aim: 0})

    return reduced.position * reduced.depth
}

console.log(navigate(input))
console.log(navigate2(input))

