#!/bin/bash

jing_file=$1 || ( echo "Necesas doni jing-eraro-dosieron sur komandlinio"; exit 1 )

xml_dir="./xml"
ERROR_PREFIX='^/([^:]+\.xml):([0-9]+):([0-9]+):'

open IN, $jing_file ||
  die "Ne povis legi $jing_file: $!\n";

cat <<EOH
<html>
  <head><title>Strukturaj neregulaĵoj trovitaj per RelaxNG (jing)</title></head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  <link title="indekso-stilo" type="text/css" rel="stylesheet" href="../stl/indeksoj.css"/>
  <body>
    <h1>Strukturaj neregulaĵoj trovitaj per RelaxNG (jing)</h1>
    <p>
      La struktura kontrolo per <a target="_new" href="../dtd/vokoxml.rnc">vokoxml.rnc</a>
      (RelaxNG) estas pli strikta ol la kontrolo per la 
      <a target="_new" href="../dtd/vokoxml.dtd">dokumenttipdifino</a> (DTD).
      La malsupraj trovaĵoj do striktasence ne estas eraroj. Sed la neregulaĵoj povas
      montri erarojn, ekz. mislokitajn tradukojn inter sencoj atribuitaj al la derivaĵo 
      anstataŭ al la senco. Aŭ ili povas konfuzi postajn redaktantojn, kiuj ne atendas 
      la informojn en nekutima loko.
   </p>
   <p>
     La kontrolo ankaŭ trovas markojn neregule formitajn, gramatikajn informojn malĝuste etikeditajn
     kiel vortospeco k.a.
   </p>
   <p>
     La RelaxNG-strukturo estas ankoraŭ iom eksperimenta kaj do diskutinda. Do eble ne 
     ĉiu malsupra trovita neregulaĵo meritas korekton. 
   </p>
EOH

while read -r line; do 
  if [[ ${line} =~ ${ERROR_PREFIX}(.*) ]]; then
	  file=${BASH_REMATCH[1]}
	  line=${BASH_REMATCH[2]}
	  col=${BASH_REMATCH[3]}
	  error=${BASH_REMATCH[4]}
    fn=$(basename -- "$file")
    art=${fn%*.xml}
    echo "<dt> <a target='precipa' href=\"../art/${art}.html\">${art}:${line}:${col}</a>:</dt>"
    echo "<dd>${error}</dd>"
  else
	  echo "Okazis eraro, atendis dosiernomon, sed trovis: \"${line}\""
    exit 1
  fi
done < ${jing_file}


date=`date +"%Y-%m-%d %H:%M"`

print <<EOT
  <p>
    Generita je ${date}
  </p>
  </body>
</html>
EOT



