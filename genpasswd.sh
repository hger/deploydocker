#!/bin/bash

wordsfile="/usr/share/dict/words"

if [ ! $wordsfile ];then
	echo
	echo "##################################################"
	echo Requires the words file please change the variable
	echo wordsfile in script to point to your words file
	echo "##################################################"
	echo
	exit 1
fi

#Get random number from 4-7 to get from words
xlen=$((RANDOM%3+4))
#Get other half of number so total is 10
let "ylen = 10 - $xlen"
#Get a word of variable lenght for first part of password
x=$(awk "length == $xlen" $wordsfile | grep -v \- | grep -v \/ | grep -v \' | grep -v \\. | shuf -n1 | tr '[:upper:]' '[:lower:]')
#Get a word of variable lenght for second part of password
y=$(awk "length == $ylen" $wordsfile | grep -v \- | grep -v \/ | grep -v \' | grep -v \\. | shuf -n1 | tr '[:upper:]' '[:lower:]')
#Capitalize variable y
y=$(echo ${y~})
#Get a randum number between 10 and 99
n=$(shuf -i10-99 -n1)
#Print the result
echo "$x$n$y"

exit 0
