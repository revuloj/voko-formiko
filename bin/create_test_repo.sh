#!/bin/bash
  
rm -rf test-repo  
mkdir test-repo
cd test-repo
git init

mkdir bld 
mkdir revo

echo "<xml>" > bld/test.svg

cat << EOF1 > revo/artefakt.xml
<?xml version="1.0"?>
<!DOCTYPE vortaro SYSTEM "../dtd/vokoxml.dtd">
<vortaro>
<art mrk="\$Id\$">
<kap>
  <rad>artefakt</rad>/o <fnt><bib>SPIV</bib></fnt>
</kap>
<drv mrk="artefakt.0o">
  <kap><tld/>o</kap>
  <snc mrk="artefakt.0o.ARKE">
    <uzo tip="fak">ARKE</uzo>
    <dif>
      <ref tip="dif" cel="art.0efaritajxo.KOMUNE">Artefarita&jcirc;o</ref>,
      objekto prilaborita por iu celo a&ubreve; uzo
      kontraste al a&jcirc;o rezultanta de natura procezo:
      <ekz>
        ritaj <tld/>oj el tombo 268 de la tombejo &Gcirc;arkutan 4B
        <fnt>
          <aut>V. I. Ionesov</aut>
          <vrk><url
          ref="http://www.eventoj.hu/steb/arkeologio/baktrio/baktrio2.htm">
          Kulturo kaj socio de Norda Baktrio</url></vrk>
          <lok>Scienca Revuo, 1992:1 (43), p. 3a-8a</lok>
        </fnt>.
      </ekz>
    </dif>
  </snc>
  <trd lng="fr">artefact</trd>
</drv>
</art>
<!--
\$Log\$
-->
</vortaro>
EOF1

git config --global user.email "neniu@example.com"
git config --global user.name "Ja Neniu"

git add bld revo
git commit -m"v1"
git tag "v1"

cat << EOF2 > revo/modif.xml
<?xml version="1.0"?>
<!DOCTYPE vortaro SYSTEM "../dtd/vokoxml.dtd">

<vortaro>
<art mrk="\$Id\$">
<kap>
  <ofc>3</ofc>
  <rad>modif</rad>/i
</kap>
<drv mrk="modif.0i">
  <kap><tld/>i</kap>
  <gra><vspec>tr</vspec></gra>
  <snc>
    <dif>
      Parte &scirc;an&gcirc;i ion ne tu&scirc;ante la esencon:
      <ekz>
        <tld/>i la formon de;
      </ekz>
      <ekz>
        <tld/>i projekton, le&gcirc;on, aran&gcirc;on.
      </ekz>
    </dif>
  </snc>
</drv>
</art>
<!--
\$Log\$
-->
</vortaro>
EOF2

git add revo
git commit -m"v2"
git tag "v2"
