#!/bin/bash

viki_url=http://download.wikimedia.org/eowiki/latest/eowiki-latest-all-titles-in-ns0.gz
#viki_local=${HOME}/tmp/eoviki.gz
viki_local=./tmp/eoviki.gz

#wget -nv ${viki_url} -O $viki_local
          
echo '<?xml version="1.0"?>'
echo '<viki>'          
# Elfiltru tiujn titolojn, kiuj ne enhavas ion krom literoj kaj strekoj,
# la dua litero estu minusklo por eksludi mallongigojn.
# Ni akceptas ankaŭ literojn ciriclajn ktp. pro simpligo.
# Restos tiel proksimume 2/3 de la titoloj. La substrekon ni jam anstataŭigas per spaco(?)
gzip -d < $viki_local | grep -E "^[[:upper:]][-[:lower:]][-_[:alpha:]]*$" | sed -E 's%^(.*)$%<v>\1</v>%' # | sed 's/_/ /g'

echo '</viki>'

# por ŝarniri la viki-titolojn kun la derivaĵoj/kapvorotj ni bezonas ekstrakti poste
# el inx_kat.xml parojn @mrk=k laŭ //v@mrk/k
#
# sur tiu paĝo estas xml-iloj konsiderindaj por tiu tasko: https://github.com/dbohdan/structured-text-tools#xml-html

