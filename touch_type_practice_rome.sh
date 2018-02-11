#!/bin/bash
declare -a MOTHER=('a' 'i' 'u' 'e' 'o')
declare -a CHILD=( \
  'b' 'c' 'd' 'f' 'g' 'h' 'j' 'k' 'l' 'm' \
  'n' 'p' 'q' 'r' 's' 't' 'v' 'w' 'x' 'y' \
  'z')

handler() {
  kill -9 $$
}
trap handler 0 1 2 3 15

main() {
  declare -i missed=0
  declare -i no=0
  declare -i id_aiueo=0
  declare -i id_child=0
  declare -i score=0
  local word=0
  local word_in=0

  echo 'Practice start.'

  while [[ 1 ]]; do
    if [[ ${missed} -ne 1 ]]; then
      id_aiueo=$(($RANDOM % ${#MOTHER[@]}))
      id_child=$(($RANDOM % ${#CHILD[@]}))
      miss=0
    fi
    word="${CHILD[${id_child}]}${MOTHER[${id_aiueo}]}"
    echo "No.${no}"
    echo ">${word}"
    read -s -n2 word_in

    # The asked num is counted
    ASK_CNT[${id_aiueo}]=$((${ASK_CNT[${id_aiueo}]} + 1))

    # Judge
    if [[ ${word_in} = ${word} ]]; then
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
    fi
    no=$((${no} + 1))
  done

  echo 'Practice stop.'
}
main
