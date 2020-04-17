#!/bin/bash

# ni supozas, ke ni estas revo-fonto/revo, t.e. en la
# dosierujo kie enestas la XML-dosieroj, do ili donitaj
# kiel argumentoj ($@) ne havas padon kiel prefikso!

if [ $# -eq 0 ]; then
  echo '<?xml version="1.0" encoding="UTF-8"?>'
  echo '<changelog></changelog>'
  >&2 echo "Vi devas doni la liston de dosieroj, por kiu ni eltrovu la historion."
  exit 1
fi

# ĉiuj eroj de la historio
commits="HEAD"
filelist=$(echo $@ | tr '\n' ' ')

# https://gist.github.com/rhochreiter/4666858 
revlist=$(git rev-list $commits -- $@)
(
  echo '<?xml version="1.0" encoding="UTF-8"?>'
  echo '<changelog>'

  # debugging
  echo "<!-- "
  echo "$filelist"
  echo "-->"

  for rev in $revlist
  do
	# malnova git 1.8 ne subtenas: --date=format:'%Y-%m-%d %H:%M' 
    echo "$(git log -1 --date=short --pretty=format:"<entry revision=\"%h\">%n<date>%ad</date>%n<msg><![CDATA[%s]]></msg>%n" $rev)"
    files=$(git log -1 --pretty="format:" --name-only $rev)
    #echo '<paths>'
    for file in $files
    do
      filename=${file#"revo/"}
      # konsideru nur dosierojn donitajn kiel argumento kaj 
      # ignoru aliajn samtempe ŝanĝitajn
      if [[ " $filelist " =~ " ${filename} " ]]; then
        echo "<file><name>$filename</name></file>"
      else
        echo "<!-- ign: ${filename} -->"
      fi
    done
    #echo '</paths>'
    echo '</entry>'
  done
  echo '</changelog>'
)

