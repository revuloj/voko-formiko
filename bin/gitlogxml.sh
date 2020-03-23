#!/bin/bash

from=$1

if [[ ! -z "$from" ]]; then
  # ĉiuj post $from
  commits="$from..HEAD"
else
  # ĉiuj
  commits="HEAD"
fi  

# https://gist.github.com/rhochreiter/4666858 
revlist=$(git rev-list $commits)
(
  echo '<?xml version="1.0" encoding="UTF-8"?>'
  echo '<changelog>'
  for rev in $revlist
  do
	# malnova git 1.8 ne subtenas: --date=format:'%Y-%m-%d %H:%M' 
    echo "$(git log -1 --date=short --pretty=format:"<entry revision=\"%h\">%n<date>%ad</date>%n<msg><![CDATA[%s]]></msg>%n" $rev)"
    files=$(git log -1 --pretty="format:" --name-only $rev)
    #echo '<paths>'
    for file in $files
    do
      filename=${file#"revo/"}
      echo "<file><name>$filename</name></file>"
    done
    #echo '</paths>'
    echo '</entry>'
  done
  echo '</changelog>'
)

