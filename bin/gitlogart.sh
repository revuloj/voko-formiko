#!/bin/bash

# por krei la historion de artikolo, vi troviĝu ene de la Git-arĥivo, ekz. $HOME/revo-fono/revo

# kiel plirapidigi...?
# https://stackoverflow.com/questions/35186829/how-to-improve-git-log-performance

# La arĥivo-URL uzata malsupre por referenci al unopaj eldonoj per "hash"
repo='https://github.com/revuloj/revo-fonto/commit/'

if [[ "$1" == *".xml" ]]; then
  art=$1
  nom=${art%.xml}
else
  nom="$1"
  art="$1.xml"
fi  

if [[ ! -f "$art" ]]; then
  >&2 echo "ERARO: dosiero $art ne ekzistas."
  >&2 echo "pwd: $(pwd)"
  exit 1
fi 

# referenco al la artikolo en la servilo reta-vortaro.de
href="http://reta-vortaro.de/revo/art/$nom.html"

cat <<EOH
<html>
  <head>
    <title>Historio de $art</title>
    <link rel="stylesheet" type="text/css" href="../stl/artikolo.css">
  </head>
  <body>
    <h1>Historio de <a href="$href">$nom</a>.xml</h1>
    <table class="art-hist">
EOH

revlist=$(git rev-list HEAD -- $art)
(
  for rev in $revlist
  do
    changed=$(git log -1 --pretty=format:"%s" $rev \
      | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g')   
    # malnova git 1.8 ne subtenas --date=format:'%Y-%m-%d %H:%M' 
    echo "$(git log -1 --date=short \
      --pretty=format:"<tr><td>%ad</td><td><a target=\"_new\" href=\"$repo%h\">%h</a></td>" $rev)"
    echo "<td>$changed</td></tr>"
  done
)

cat <<EOF
    </table>
  </body>
</html>
EOF


