#!/usr/bin/env zsh

source ~/.zshrc

YEAR=2022
SESSION=$(<.session)

DAY="$(date +%-d)"
TIME="$(date +%-H)"
[[ $(($TIME < 7)) == 1 ]] && DAY=$(($DAY - 1))

DIR=$DAY
[[ $((DAY < 10)) == 1 ]] && DIR="0$DAY"

echo "It's day $DAY!"
echo "Checking for $DIR..."

if ! [ -d "$DIR" ]
then
  echo "Setting up $DIR..."
  mkdir $DIR
  cp templates/* $DIR
  cd $DIR

  URL="https://adventofcode.com/$YEAR/day/$DAY/input"
  HEADER="cookie: session=$SESSION"
  curl --silent $URL -H $HEADER > input.txt
  echo "Done!"
else
  cd $DIR
fi

open "https://adventofcode.com/$YEAR/day/$DAY"
vig solution.rb
