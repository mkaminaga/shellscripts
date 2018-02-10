#!/bin/bash

declare -a CHAR_LIST=( \
  'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' \
  'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' \
  'u' 'v' 'w' 'x' 'y' 'z' '0' '1' '2' '3' \
  '4' '5' '6' '7' '8' '9' ',' '.' '/' ';' \
  ':' '@' '[' ']' '-' '^')
declare -a ASK_CNT
declare -a ERR_CNT
declare -i LOOP_END=0

handler() {
  LOOP_END=1

  echo ""
  echo '==== Result ===='
  declare -i total_ask=0
  declare -i total_err=0
  local err_rate=0
  echo 'no/character/count/error'
  for i in $(seq 0 $((${#CHAR_LIST[@]} - 1))); do
    # Show
    if [[ ${ASK_CNT[${i}]} -ne 0 ]]; then
      err_rate=$(echo "scale=20; ${ERR_CNT[${i}]}/${ASK_CNT[${i}]} * 100.0" | bc)
      err_rate=$(printf '%.1f' ${err_rate})
    else
      err_rate=0
    fi
    echo "${i} ${CHAR_LIST[${i}]} ${ASK_CNT[${i}]} ${err_rate}%"
    # Sum
    total_ask=$((${total_ask} + ${ASK_CNT[${i}]}))
    total_err=$((${total_err} + ${ERR_CNT[${i}]}))
  done
  if [[ ${total_ask} -ne 0 ]]; then
    err_rate=$(echo "scale=20; ${total_err}/${total_ask} * 100.0" | bc)
    err_rate=$(printf '%.1f' ${err_rate})
  else
    err_rate=0
  fi

  echo '---- Total Result ----'
  echo "asked count : ${total_ask}"
  echo "error count : ${total_err}"
  echo "error rate : ${err_rate}%"
  echo "score : ${score}"

  # Self terminate
  kill -9 $$
}
trap handler 0 1 2 3 15

main() {
  declare -i missed=0
  declare -i no=0
  declare -i id=0
  declare -i score=0
  local c=0
  local cin=0

  # Reserve array
  for i in $(seq 0 $((${#CHAR_LIST[@]} - 1))); do
    ASK_CNT+=('0')
    ERR_CNT+=('0')
  done

  echo 'Practice start.'

  while [[ ${LOOP_END} -eq 0 ]]; do
    if [[ ${missed} -ne 1 ]]; then
      id=$(($RANDOM % ${#CHAR_LIST[@]}))
      miss=0
    fi
    c=${CHAR_LIST[${id}]}
    echo "No.${no}: ${c}"
    read -s -n1 cin
    # The asked num is counted
    ASK_CNT[${id}]=$((${ASK_CNT[${id}]} + 1))
    # Judge
    if [[ ${cin} = ${c} ]]; then
      missed=0
      echo 'Good.'
      echo "score=${score}"
      echo ""
      score=$((${score} + 1))
    else
      missed=1
      echo '*=*=*=*=* Not that! XD *=*=*=*=*'
      echo "score=${score}"
      echo ""
      score=$((${score} - 10))
      # The error is counted
      ERR_CNT[${id}]=$((${ERR_CNT[${id}]} + 1))
    fi
    no=$((${no} + 1))
  done

  echo 'Practice stop.'
}
main
