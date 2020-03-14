#!/bin/bash

datetime=$(date +%Y%m%d_%H%M%S)

cd ${REVO}

while getopts "rap" OPT; do
  case ${OPT} in
    r)
      command="ant -file ${VOKO}/ant/redaktoservo.xml srv-resumo 2>&1"
      echo -e "${command}\nTIME:" $(date)"\n"
      exec ${command}
      ;;
    a)
      target="srv-servo-art"
      ;;
    p)
      target="srv-purigu"
      ;;
    *)
      # nepre rekreu la vortaron eĉ se tiufoje ne alvenis poŝto  
      target="-Duser-mail-file-exists=true srv-servo"
      # target="srv-servo"
  esac
done

if [[ -d ${HOME}/revolog ]]; then
  log="${HOME}/revolog/redsrv-${datetime}.log"
else  
  log="${HOME}/log/redsrv-${datetime}.log"
fi  
command="ant -file ${VOKO}/ant/redaktoservo.xml ${target} 2>&1 | tee ${log}"
echo -e "${command}\nTIME:" $(date)"\n"
exec ${command}

