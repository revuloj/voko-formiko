#!/bin/bash

datetime=$(date +%Y%m%d_%H%M%S)
target="-Duser-mail-file-exists=true srv-servo"

cd ${REVO}

while getopts "rap" OPT; do
  case ${OPT} in
    r)
      target="srv-resumo"
      # ne skribu protokolon, nur sendu tra cron!
      command="ant -file ${VOKO}/ant/redaktoservo.xml srv-resumo"
      echo -e "${command}\nTIME:" $(date)"\n"
      exec ${command} 2>&1
      ;;
    a)
      target="srv-servo-art"
      ;;
    p)
      target="srv-purigu"
      ;;
    *)
      # ĉu eldoni informojn kiel uzi...?
  esac
done

if [[ -d ${HOME}/revolog ]]; then
  log="${HOME}/revolog/redsrv-${datetime}.log"
else  
  log="${HOME}/log/redsrv-${datetime}.log"
fi  
command="ant -file ${VOKO}/ant/redaktoservo.xml ${target}" 
echo -e "${command}\nTIME:" $(date)"\n"
exec ${command} 2>&1 | tee ${log}

