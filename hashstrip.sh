#!/bin/bash
if [ -z $1  ];then
	echo "No arguments supplied"
	echo "Usage: hashstrip.sh [filename containing VT file URLs, one per line]"
	exit 1
fi

cat $1 | cut -d"/" -f6

exit 0
