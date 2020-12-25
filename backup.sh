#!/bin/bash

lastBackup=$(ls ~ | grep -E "^Backup-" | sort -n | tail -1)
lastDate=$(echo $lastBackup | cut -c "8-17")
lastDateSec=$(date -d "$lastDate" +%s)
newDate=$(date +"%Y-%m-%d")
newDateSec=$(date -d "$newDate" +%s)
let dateDiff=($newDateSec-$lastDateSec)/3600/24

if [[ "$dateDiff" -ge 7 ]]
then
	mkdir ~/Backup-$newDate
	files=$(ls ~/source)
	for file in $files
	do
	cp ~/source/$file ~/Backup-$newDate
	done
	echo "New Backup:$HOME/Backup-$newDate;Files:$files" >> ~/backup-report
else
	files=$(ls ~/source)
	temp="Change Backup:date:$newDate;$HOME/$lastBackup;New Files:"
	changedFilesTemp="Changed Files"
	for file in $files
	do
	if [[ ! -f ~/$lastBackup/$file ]]
	then
		cp ~/source/$file ~/$lastBackup
		temp="$temp $file"
	else
		lastSize=$(stat -c%s ~/$lastBackup/$file)
		newSuze=$(stat -c%s ~/source/$file)
		if [[ $lastSize -ne $newSize ]]
		then
			mv ~/$lastBackup/$file ~/$lastBackup/$file.$newDate
			cp ~/source/$file ~/$lastBackup/$file
			changedFilesTemp="$changedFilesTemp $file $file.$newDate,"
		fi
	fi
	echo "$temp;$changedFilesTemp" >> ~/backup-report
done
fi
