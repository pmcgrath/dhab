#!/usr/bin/env sh
version=Pending

seq=1
while :; do
	echo "v$version Working on iteration $seq"
	seq=$((seq+1))
	sleep 1
done
