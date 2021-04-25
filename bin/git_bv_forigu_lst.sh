#!/bin/bash

from=$1
path=$2

list=$(git show --name-only --oneline --diff-filter=D ${from}.. -- ${path} \
  | grep -E "^revo/[^ /]+\.xml$" | sed 's/^revo\///g' | sort | uniq)

#echo ${list}
for file in ${list}
do
  art=${file%*.xml}
  echo revo/art/${art}.html
  echo revo/hst/${art}.html
  echo revo/tez/${art}.json
  echo revo/xml/${art}.xml
done