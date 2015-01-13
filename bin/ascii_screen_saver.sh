#!/bin/bash
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
for i in `find ./ -name '*.jpg'`; do
	echo ${i}
	jp2a --term-fit --background=dark ${i};
	sleep 5;
done
IFS=$SAVEIFS

