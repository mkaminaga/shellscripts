﻿#!/bin/bash
# 2018/02/11
# Mamoru Kaminaga
# Tool for touch type practice.
readonly TMPFILE=$(mktemp)

handler() {
  rm ${TMPFILE}

  # Self terminate
  kill -9 $$
}
trap handler 0 1 2 3 15

main() {
  local text_file=${1}

  declare -a word_list
  declare -a skip_list
  declare -i ask_cnt=0
  declare -i err_cnt=0
  declare -i missed=0
  declare -i no=0
  declare -i id=0
  declare -i score=0
  local word=""
  local word_in=""

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
  echo "open ${text_file}"
  while read -a word || [ "${word}" != "" ]; do
    if [[ "${word:0:1}" != "#" ]]; then
      word_list+=(${word})
      echo "${word}"
      skip_list+=(0)
    fi
  done < ${text_file}
  echo "----"
  echo "Total ${#word_list[@]} words are loaded"
  echo ""

  echo "----"
  echo 'Practice start'
  echo ""

  while [[ 1 ]]; do
    if [[ ${missed} -eq 0 ]]; then
      # 1st time success words are skipped.
      id=$(($RANDOM % ${#word_list[@]}))
      while [[ ${skip_list[${id}]} -eq 1 ]]; do
        id=$(($RANDOM % ${#word_list[@]}))
      done

      # The word is read.
      missed=0
      word=${word_list[${id}]}
    fi
    echo "No.${no}: ${word}"
    read -n${#word_list[${id}]} word_in

    # The asked num is counted
    ask_cnt=$((${ask_cnt} + 1))

    # Judge
    if [[ ${word_in} = ${word} ]]; then
      # 1st time success word is memorized.
      if [[ ${missed} -eq 0 ]]; then
        sed -e "s/[^#]*${word}/#${word}/g" ${text_file} > ${TMPFILE}
        cp ${TMPFILE} ${text_file}
        skip_list[${id}]=1
      fi

      missed=0
      echo ""
      echo -e "\e[36m>Good.\e[m"
      echo "score=${score}"
      echo ""
      score=$((${score} + 1))
    else
      missed=1
      echo ""
      echo -e "\e[31m>Incorrect!\e[m"
      echo "score=${score}"
      echo ""
      score=$((${score} - 5))
      # The error is counted
      err_cnt=$((${err_cnt} + 1))
    fi
    no=$((${no} + 1))
  done

  echo 'Practice stop.'
}
main ${1}
