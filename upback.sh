#!/bin/bash

if [[ ! -d ~/restore ]]
then
mkdir ~/restore
fi

backup=$(ls ~ | grep -E "^Backup-" | sort -n | tail -1)

if [[ -z $backup ]]
then
echo "There're no one backup"
exit 1
fi

files=$(ls ~/$backup | grep -Ev "\.[0-9]{4}-[0-9]{2}-[0-9]{2}$")
for file in $files
do
cp ~/$backup/$file ~/restore
done
