#!/bin/bash
set +e
set +x

MP=mpost

# pro cimo en mpost-PNG 1.999 ni uzis rsvg-convert
# sed nun rsvg-convert fuŝas kaj mpost-PNG denove funkcias:
# specifa problemo kun rsvg-convert: ne bone funkcias eltondi formon el alia kiel ĉe GRA, FON
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
