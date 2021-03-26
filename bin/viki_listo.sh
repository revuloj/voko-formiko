#!/bin/bash

viki_url=http://download.wikimedia.org/eowiki/latest/eowiki-latest-all-titles-in-ns0.gz
viki_local=${HOME}/tmp/eoviki.gz
#viki_local=./tmp/eoviki.gz
#viki_listo=${HOME}/tmp/inx_tmp/viki_listo.xml

curl -Lo $viki_local ${viki_url} 
          
echo '<?xml version="1.0"?>' 
echo '<viki>'
# Elfiltru tiujn titolojn, kiuj ne enhavas ion krom literoj kaj strekoj,
# la dua litero estu minusklo por eksludi mallongigojn.
# Ni akceptas ankaŭ literojn ciriclajn ktp. pro simpligo.
# Restos tiel proksimume 2/3 de la titoloj. 
gzip -d < $viki_local | grep -E "^[[:upper:]][-[:lower:]][-_[:alpha:]]*$" | sed -E 's%^(.*)$%<v>\1</v>%'

echo '</viki>'


