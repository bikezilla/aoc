import * as fs from 'fs'
import _ from 'lodash'

const real = fs.readFileSync(`${__dirname}/input.txt`).toString()
const example = `mjqjpqmgbljsphdztnvjfqwrcgsmlb`

const test = false
const input = (test ? example : real).split('\n')[0]

const packetSize = 14

for (let i = 0; i < input.length - packetSize; i++) {
  const marker = input.slice(i, i + packetSize)

  if (_.uniq(marker).length == packetSize) {
    console.log(i + packetSize)
    break
  }
}
