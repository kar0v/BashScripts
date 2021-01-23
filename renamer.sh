!#/bin/bash
LINES=$(find ./ -iname "*.c*")
for i in $LINES
do
	mv $i ${i%c}h
done
