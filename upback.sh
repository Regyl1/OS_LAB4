#!/bin/bash

if [[ -d ~/restore ]]
then
mkdir ~/restore
fi

dir=$(ls ~ | grep -E "^Backup-" | sort -n | tail -1)

if [[ -z $dir ]]
then
echo "There're no Backups"
exit 1
fi

for file in $(ls ~/dir | grep -Ev ".[0-9]{4}-[0-9]{2}-[0-9]{2}$")
do
cp $file ~/restore
done
