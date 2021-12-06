import * as fs from 'fs';
import _ from 'lodash';

type Point = {
    x: number
    y: number
}

type Line = {
    from: Point
    to: Point
}

function isParallelToAxes(line: Line): boolean {
    return line.from.x == line.to.x || line.from.y == line.to.y
}

function axis(line: Line, d: 'x' | 'y'): number[] {
    const o = d == 'x' ? 'y' : 'x'

    if (line.from[d] == line.to[d]) {
        return Array(Math.abs(line.from[o] - line.to[o]) + 1).fill(line.from[d])
    } else {
        return _.range(line.from[d], line.to[d] + ((line.from[d] - line.to[d]) < 0 ? 1 : -1))
    }
}

function walk(line: Line, fn: (y: number, x: number) => void): void {
    const coordinates = _.zip(axis(line, 'y'), axis(line, 'x')) as unknown as [number, number][]

    coordinates.forEach(c => fn(c[0], c[1]))
}

function mapVents(lines: Line[]): number[][] {  
    const result: number[][] = []

    lines.forEach(line => {
        walk(line, (y, x) => {
            result[y] ||= []
            result[y][x] = (result[y][x] ||0) + 1
        })
    })
    
    return result
}

function overlapping(map: number[][]): number {
    return map.flat().filter(e => e > 1).length
}

const input = fs.readFileSync('input/05.txt').toString().trim().split('\n')
const lines: Line[] = input.map(line => {
    const [fromX, fromY, toX, toY] = line.split('->').flatMap(x => x.split(',')).map(x => parseInt(x))
    
    return {from: {x: fromX, y: fromY}, to: {x: toX, y: toY}}    
})

console.log(overlapping(mapVents(lines.filter(l => isParallelToAxes(l)))))
console.log(overlapping(mapVents(lines)))




