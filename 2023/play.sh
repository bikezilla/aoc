#!/usr/bin/env zsh

source ~/.zshrc

YEAR=2023
SESSION=$(<.session)

DAY="$(date +%-d)"
TIME="$(date +%-H)"
[[ $(($TIME < 7)) == 1 ]] && DAY=$(($DAY - 1))

DIR=$DAY
[[ $((DAY < 10)) == 1 ]] && DIR="0$DAY"

echo "It's day $DAY!"

cd $DIR

echo "$(pwd)"

#echo "Checking for $DIR..."
#if ! [ -d "$DIR" ]
#then
  #echo "Setting up $DIR..."
  #mkdir $DIR
  #cp templates/* $DIR
  #cd $DIR

  #URL="https://adventofcode.com/$YEAR/day/$DAY/input"
  #HEADER="cookie: session=$SESSION"
  #echo "Getting input ..."
  #curl --silent $URL -H $HEADER > input.txt

  #echo "Done!"
  #open "https://adventofcode.com/$YEAR/day/$DAY"
  #vig solution.rb
#else
  #cd $DIR
#fi

