#!/bin/bash

if [[ $# != 1 ]]
then
echo "Wrong amount of parameters"
exit 1
fi

if [[ ! -f $1 ]]
then
echo "File is not exist"
fi

if [[ ! -d "~/.trash" ]]
then
mkdir "~/.trash"
fi

if [[ ! -d "/.trash/counter" ]]
then
echo "1" > "/.trash/counter"
fi

number =  $(cat "~/.trash/counter")
ln "$pwd/$1" "~/.trash/number"
rm "$pwd/$1"
echo "$number:$pwd/$1" >> "~/.trash.log"

let number=$number+1
echo "$number" > "~/.trash/counter"
