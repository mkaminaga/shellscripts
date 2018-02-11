#!/bin/bash
# 2018/02/11
# Mamoru Kaminaga
# Tool for touch type practice.

declare -a WORD_LIST
declare -i ASK_CNT=0
declare -i ERR_CNT=0

handler() {
  # Self terminate
  kill -9 $$
}
trap handler 0 1 2 3 15

main() {
  local text_file=${1}

  declare -i missed=0
  declare -i no=0
  declare -i id=0
  declare -i score=0
  local word
  local word_in

  # The specified file is checked.
  if [[ "${text_file}" = "" ]]; then
    echo 'Error... File name is not specified'
    exit 1
  fi
  if [[ ! -e ${text_file} ]]; then
    echo 'Error... File does not exist'
    exit 1
  fi

  # The file is loaded.
  local word_num=0
  echo "open ${text_file}"
  while read -a word || [ "${word}" != "" ]; do
    WORD_LIST+=(${word})
    echo "${word}"
    word_num=$((${word_num} + 1))
  done < ${text_file}
  echo "Total ${word_num} words"
  echo ""

  echo 'Practice start'
  echo ""

  while [[ 1 ]]; do
    if [[ ${missed} -ne 1 ]]; then
      id=$(($RANDOM % ${#WORD_LIST[@]}))
      missed=0
    fi
    word=${WORD_LIST[${id}]}
    echo "No.${no}: ${word}"
    read -n${#WORD_LIST[${id}]} word_in
    # The asked num is counted
    ASK_CNT=$((${ASK_CNT} + 1))
    # Judge
    if [[ ${word_in} = ${word} ]]; then
      missed=0
      echo ""
      echo 'Good.'
      echo "score=${score}"
      echo ""
      score=$((${score} + 1))
    else
      missed=1
      echo ""
      echo '*=*=*=*=* Not that! XD *=*=*=*=*'
      echo "score=${score}"
      echo ""
      score=$((${score} - 5))
      # The error is counted
      ERR_CNT=$((${ERR_CNT} + 1))
    fi
    no=$((${no} + 1))
  done

  echo 'Practice stop.'
}
main ${1}
