#!/bin/bash

if [[ "$#" != 1 ]]
then
echo "Wrong amount of parameters"
exit 1
fi

if [[ ! -f "$1" ]]
then
echo "File is not exist"
exit 1
fi
if [[ ! -d ~/.trash ]]
then
mkdir ~/.trash
fi

if [[ ! -e ~/.trash/counter ]]
then
echo "1" > ~/.trash/counter
fi

number=$(cat ~/.trash/counter)
filePath="$PWD/$1"

ln "$filePath" ~/.trash/$number
rm "$filePath"
echo "$number:$filePath" >> ~/.trash.log

let number=$number+1
echo $number > ~/.trash/counter
