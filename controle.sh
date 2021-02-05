#!/bin/bash
# Colors
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"
COL_BLUE=$ESC_SEQ"34;01m"
COL_MAGENTA=$ESC_SEQ"35;01m"
COL_CYAN=$ESC_SEQ"36;01m"

echo -e $COL_BLUE  "Controle op pid  $1 on gaat van start" $COL_RESET

while true; do
  ps -p $1 > /dev/null
  r=$?
  if [ $r -ne 0 ];then
  #if [ $r -eq 0 ]; then
    echo -e $COL_RED "pid is currently no longer running" $COL_RESET
    ./encoder.sh
    break
  fi
done