#!/bin/bash
#set -x

DB=$1;
dir=$2;

#for file in "$dir"; do
#    echo "$file"
#done

for file in ${dir}/*.html; 
do 

    [ -e "$file" ] || continue
    echo "shovas $file en $DB..."

	filename=$(basename -- "$file")
	#extension="${filename##*.}"
	mrk="${filename%.*}"
	# echo "${art}"

	hex=$(hexdump -ve '1/1 "%02X"' $file)
	{
		echo "INSERT into artikolo(mrk,txt) VALUES('${mrk}',X'${hex}');"
		echo ".quit"
	} |	/usr/bin/sqlite3 ${DB}

done

