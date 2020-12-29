#!/bin/bash

if [[ $# != 1 ]]
then
echo "Wrong amount of parameters"
exit 1
fi

if [[ ! -f ~/.trash.log ]]
then
echo "trash.log doesn't exists"
exit 1
fi

for line in $(grep -F "$1" ~/.trash.log)
do
number=$(echo $line | awk -F ':' '{print $1}')
link=$(echo $line | awk -F ':' '{print $2}')
if [[ -n $(echo $link | grep -F $1) ]]
then
	echo "Untrash this file(y/n): $link ?"
	read com
	if [[ $com == 'y' ]]
	then
	dir=$(echo $link | awk -F "/$1" '{print $1}')
	name=$1
	if [[ ! -d $dir ]]
	then
		echo "Directory was deleted, untrash in home directory"
		dir=~
	fi
	while [[ -f $dir/$name ]]
	do
		echo "This file alreay exists. Write new name"
		read name
	done
	ln ~/.trash/$number $dir/$name
	rm ~/.trash/$number
	grep -v $line ~/.trash.log > ~/.trash.log
	fi
fi
done

