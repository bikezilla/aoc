import * as fs from 'fs'

const real = fs.readFileSync(`${__dirname}/input.txt`).toString()
const example = `
1000
2000
3000

4000

5000
6000

7000
8000
9000

10000
`

const test = true
const input = (test ? example : real).split('\n').slice(1, -1)

const sums: number[] = []
let currentSum = 0

input.forEach((line: string) => {
  if (line.length !== 0) {
    currentSum += parseInt(line)
  } else {
    sums.push(currentSum)
    currentSum = 0
  }
})
sums.push(currentSum)

const result = sums.sort((a, b) => b - a)

console.log(result[0])
console.log(result.slice(0, 3).reduce((acc, i) => acc + i))
