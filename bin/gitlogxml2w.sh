#!/bin/sh

# https://gist.github.com/rhochreiter/4666858 
two_weeks=$(date -d "14 days ago" +"%Y-%m-%d")
revlist=$(git rev-list --since=$two_weeks HEAD)
(
  echo '<?xml version="1.0" encoding="UTF-8"?>'
  echo '<changelog>'
  for rev in $revlist
  do
    echo "$(git log -1 --date=short --pretty=format:"<entry revision=\"%h\">%n<date>%ad</date>%n<msg><![CDATA[%s]]></msg>%n" $rev)"
    files=$(git log -1 --pretty="format:" --name-only $rev)
    #echo '<paths>'
    filename=${file#"revo/"}
    for file in $files
    do
      echo "<file><name>$filename</name></file>"
    done
    #echo '</paths>'
    echo '</entry>'
  done
  echo '</changelog>'
)

