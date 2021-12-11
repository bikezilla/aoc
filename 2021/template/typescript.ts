import * as fs from 'fs';
// import * as _ from 'lodash'

type INPUT = any

function parse(raw: string[]): INPUT {
    return raw
}

function solve(input: INPUT) {
    console.log(input)
}

const test = `
SMALL
INPUT
GOES
HERE
`.split("\n").slice(1, -1)

solve(parse(test))

//const file = fs.readFileSync('input.txt').toString().trim().split("\n")
//solve(parse(file))
