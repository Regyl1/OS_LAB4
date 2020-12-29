#!/bin/bash

curDate=$(date +"%Y-%m-%d")
curBackup="Backup+$curDate"
lastBackup=$(ls ~ | grep -E "^Backup-" | sort -n | tail -1)
lastDate=$(echo $lastBackup | awk -F "Backup-" '{print $2}')
changedFiles="Changed Files:"
curDateInSec=$(date -d "$curDate" +%s)
lastDateInSec=$(date -d "$lastDate" +%s)
let dateDiff=($curDateInSec-$lastDateInSec)/3600/24
echo "$dateDiff"
if [[ $dateDiff < 7 ]]
then
curBackup=$lastBackup
report="ChangeBackup:$lastBackup|time:$curDate|Files:"
else
mkdir ~/$curBackup
report="NewBackup:$curBackup|time:$curDate|FIles:"
fi

files=$(ls ~/source)
for file in $files
do
if [[ ! -f ~/$curBackup/$file ]]
then
cp ~/source/$file ~/$curBackup
report="$report $file"
else
oldFileSize=$(stat -c%s ~/$curBackup/$file)
newFileSize=$(stat -c%s ~/source/$file)
if [[ oldFileSize == newFileSize ]]
then
	cp ~/source/$file ~/$xurBackup
	report="$report $file"
else
	mv ~/$curBackup/$file ~/$curBackup/$file.$curDate
	cp ~/source/$file ~/$curBackup
	changedFiles="$changedFiles $file/$file.$curDate|"
fi
fi
done

if [[ $changedFiles != "Changed Files:" ]]
then
report="$report|$changedFiles"
fi
echo $report >> ~/backup-report
