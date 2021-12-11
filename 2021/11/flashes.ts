import * as fs from 'fs';
// import * as _ from 'lodash'

type INPUT = number[][]
interface Point {
    x: number
    y: number
}

const N = 10

function parse(raw: string[]): INPUT {
    return raw.map(line => line.split('').map(c => parseInt(c)))
}

function neighbours(x: number, y: number): Point[] {
    return([
        [x, y - 1],
        [x + 1, y - 1],
        [x + 1, y],
        [x + 1, y + 1],
        [x, y + 1],
        [x - 1, y + 1],
        [x - 1, y],
        [x - 1, y -1]    
    ].map(([x, y]) => {
        return {x, y}
    }).filter(({x, y}) => x >= 0 && y >= 0 && x < N && y < N))
}

function step(input: INPUT): [INPUT, number] {
    const result = input.map((row, y) => row.map((e, x) => e + 1))

    const flashed: boolean[][] = Array.from(Array(N), () => new Array(N))
    let collateral: Point[] = []

    do {
        collateral = []
        result.forEach((row, y) => row.forEach((e, x) => {                  
            if (result[y][x] <= 9 || flashed[y][x] == true) return

            result[y][x] = 0
            flashed[y][x] = true
            collateral.push(...neighbours(x, y))
        }))       

        collateral.
            filter(({x, y}) => flashed[y][x] != true).
            forEach(({x, y}) => result[y][x] += 1)        
    } while (collateral.length > 0)

    return [result, flashed.flat().filter(x => x).length]
}

function solve(input: INPUT) {
    const steps = 100
    let current = input
    let flashed = 0
    let newFlashed = 0

    for (let stepIndex = 1; stepIndex <= steps; stepIndex++) {
        [current, newFlashed] = step(current)
        flashed += newFlashed
    }
    
    console.log(current, flashed)
}

function solve2(input: INPUT) {    
    let current = input
    let stepIndex = 0   

    do {
        current = step(current)[0]
        stepIndex +=1
    } while (current.flat().some(x => x != 0))
    
    console.log(current, stepIndex)
}

const test = `
5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526
`.split("\n").slice(1, -1)

const file = fs.readFileSync('input.txt').toString().trim().split("\n")

solve(parse(test))
solve2(parse(test))
solve(parse(file))
solve2(parse(file))