import * as fs from 'fs';
import * as _ from 'lodash'

type ADJACENT_LIST = Map<string, string[]>

function parse(raw: string[]): ADJACENT_LIST {
    return raw.reduce((adjacent, arc) => {
        const [from, to] = arc.split('-')    
        
        adjacent.set(from, (adjacent.get(from) || []).concat([to]))
        adjacent.set(to, (adjacent.get(to) || []).concat([from]))

        return adjacent
    }, new Map())
}

function visit(node: string, pathToNode: string[], paths: string[][], graph: ADJACENT_LIST): void {
    const currentPath = pathToNode.concat([node])

    if (node == 'end') {
        paths.push(currentPath)
    } else {
        const adjacent = graph.get(node)
        if (!adjacent) return

        const toVisit = adjacent.filter(a => !currentPath.includes(a) || /^[A-Z]+$/.test(a))
        toVisit.forEach(v => visit(v, currentPath, paths, graph))
    }
}

function visit2(node: string, pathToNode: string[], paths: string[][], graph: ADJACENT_LIST): void {
    const currentPath = pathToNode.concat([node])

    if (node == 'end') {
        paths.push(currentPath)
    } else {
        const adjacent = graph.get(node)
        if (!adjacent) return
        
        const smallCaveVisitedTwice = _.chain(currentPath).filter(n => /^[a-z]+$/.test(n)).countBy().values().some(x => x > 1).value()
        const toVisit = smallCaveVisitedTwice ? adjacent.filter(a => !currentPath.includes(a) || /^[A-Z]+$/.test(a)) : adjacent.filter(a => a !== 'start')

        toVisit.forEach(v => visit2(v, currentPath, paths, graph))
    }
}

function solve(graph: ADJACENT_LIST) {
    const paths: string[][] = []
    visit('start', [], paths, graph)
    console.log(paths.length)

    const paths2: string[][] = []
    visit2('start', [], paths2, graph)    
    console.log(paths2.length)
}

const test = `
start-A
start-b
A-c
A-b
b-d
A-end
b-end
`.split("\n").slice(1, -1)

solve(parse(test))

const file = fs.readFileSync('input.txt').toString().trim().split("\n")
solve(parse(file))
