#!/bin/bash

if [[ $# != 1 ]]
then
echo "Wrong amount of parameters"
exit 1
fi

if [[ ! -d ~/.trash ]]
then
echo "No trash directory"
exit 1
fi

if [[ ! -e ~/.trash.log ]]
then
echo "No trash.log"
exit 1
fi

for i in $(grep -h $1 ~/.trash.log)
do
fileNumber=$(echo $i | awk -F ":" '{print $1}')
filePath=$(echo $i | awk -F ":" '{print $2}')
echo "Restore this file:$filePath y/n?"

read line
if [[ $line == "y" ]]
then
dir=$(echo $filePath | awk -F "/$1" '{print $1}')
if [[ ! -d $dir ]]
	then
	echo "Directory $dir doesn't exist, file will restore in home directory"
	if [[ -f $filePath ]]
		then
		echo "File name $filePath already exist, write new name"
		read newName
		ln ~/.trash/$fileNumber ~/$newName
		else
		ln ~/.trash/$fileNumber ~/$1
	fi
	else
	if [[ -f $filePath ]]
		then
		echo "File name $filePath already exist, write new name"
		read newName
		ln ~/.trash/$fileNumber $dir/$newName
		else
		ln ~/.trash/$fileNumber $filePath
	fi
fi
rm ~/.trash/$fileNumber
$(grep -v $fileNumber ~/.trash.log) > ~/.trash.log
fi
done
