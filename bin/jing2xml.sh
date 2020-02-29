#!/bin/bash

jing_file=$1 ||  ( echo "Necesas doni jing-eraro-dosieron sur komandlinio"; exit 1 )

xml_dir="./xml"
ERROR_PREFIX='^/([^:]+\.xml):([0-9]+):([0-9]+):'

# kaplinio
echo "<xml>"

# https://www.linuxjournal.com/content/bash-regular-expressions
# https://linux.die.net/Bash-Beginners-Guide/sect_04_01.html
# https://www.cyberciti.biz/faq/unix-howto-read-line-by-line-from-file/

while read -r line; do 
  if [[ ${line} =~ ${ERROR_PREFIX}(.*) ]]; then
	  file=${BASH_REMATCH[1]}
	  line=${BASH_REMATCH[2]}
	  col=${BASH_REMATCH[3]}
	  error=${BASH_REMATCH[4]}
    fn=$(basename -- "$file")
    art=${fn%*.xml}
    echo "<eraro dos='$art' lin='$line' kol='$col'>$error</eraro>"
  else
	  echo "Okazis eraro, atendis dosiernomon, sed trovis: \"$line\""
    exit 1
  fi
done < ${jing_file}

# piedlinio
date=$(date +"%Y-%m-%d %H:%M")
echo "<date>$date</date></xml>"


