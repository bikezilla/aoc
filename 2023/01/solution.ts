import * as fs from 'fs'

const real = fs.readFileSync(`${__dirname}/input.txt`).toString()
const example = `
SMALL
INPUT
GOES
HERE
`

const test = true
const input = (test ? example : real).split('\n').slice(1, -1)

const result = input

console.log(result)
