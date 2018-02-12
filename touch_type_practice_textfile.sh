#!/bin/bash
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
  declare -i skip_num=0
  declare -i missed=0
  declare -i no=0
  declare -i id=0
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
      if [[ ${#skip_list[@]} -eq ${skip_num} ]]; then
        echo 'All words are excellent! Exit'
        exit 0
      fi
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

    # Judge
    if [[ ${word_in} = ${word} ]]; then
      # 1st time success word is memorized.
      if [[ ${missed} -eq 0 ]]; then
        sed -e "s/^${word}/#${word}/g" ${text_file} > ${TMPFILE}
        cp ${TMPFILE} ${text_file}
        skip_list[${id}]=1
        skip_num=$((${skip_num} + 1))

        # 1 time clear message.
        echo ""
        echo -e "\e[32m>Excellent.\e[m"
        echo ""
      else
        # normal clear message.
        echo ""
        echo -e "\e[36m>Good.\e[m"
        echo ""
      fi

      missed=0
    else
      missed=1
      echo ""
      echo -e "\e[31m>Incorrect!\e[m"

      # The difference is shown.
      for i in $(seq 0 $((${#word} - 1))); do
        if [[ ${word_in:${i}:1} = ${word:${i}:1} ]]; then
          # Blue
          echo -e -n "\e[36m${word_in:${i}:1}\e[m"
        else
          # Red
          echo -e -n "\e[31m${word_in:${i}:1}\e[m"
        fi
      done
      echo ""

      echo ""
    fi
    no=$((${no} + 1))
  done

  echo 'Practice stop.'
}
main ${1}
