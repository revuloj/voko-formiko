#!/bin/bash
set +e
set +x

MP=mpost
# tiu ne bone funkcias por eltondi formon el alia kiel ĉe GRA, FON
# anstataŭe mpost kreas ambau svg kaj png el mp-dosiero!
# RSVG=rsvg-convert

cd smb

for file in ???.mp ????.mp
do
    #svg=${file%%.mp}.svg
    echo ${MP} ${file} #${svg}
    ${MP} ${file} #${svg}
    #png=${file%%.mp}.png
    #echo ${RSVG} -w 100 -h 100 -o ${png} ${svg}
    #${RSVG} -w 100 -h 100 -o ${png} ${svg}
done

cd ..
