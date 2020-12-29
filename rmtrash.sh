#!/bin/bash

if [[ $# != 1 ]]
then
echo "Wrong amount of Parameters"
exit 1
fi

if [[ ! -f $1 ]]
then
echo "This file doesn't exists"
exit 1
fi

if [[ ! -d ~/.trash ]]
then
mkdir ~/.trash
fi

if [[ ! -f ~/.trash/counter ]]
then
echo "0" > ~/.trash/counter
fi

num=$(cat ~/.trash/counter)
ln $PWD/$1 ~/.trash/$num
rm $PWD/$1

echo $num:$PWD/$1 >> ~/.trash.log
let num=$num+1
echo $num > ~/.trash/counter
