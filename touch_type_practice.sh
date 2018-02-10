#!/bin/bash

main() {
  local list=(\
    'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' \
    'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' \
    'u' 'v' 'w' 'x' 'y' 'z' '0' '1' '2' '3' \
    '4' '5' '6' '7' '8' '9' ',' '.' '/' '\' \
    ';' ':' '@' '[' ']' '-' '^')
  declare -i missed=0
  declare -i no=0
  declare -i id=0
  declare -i score=0
  local c=0
  local cin=0

  echo 'Practice start.'

  while [[ 1 ]]; do
    if [[ ${missed} -ne 1 ]]; then
      id=$(($RANDOM % 36))
      miss=0
    fi
    c=${list[${id}]}
    echo "No.${no}: ${c}"
    read -s -n1 cin
    if [[ ${cin} = ${c} ]]; then
      missed=0
      echo 'Good.'
      echo "score=${score}"
      echo ""
      score=$((${score} + 1))
    else
      missed=1
      echo 'Fail.'
      echo "score=${score}"
      echo ""
      score=$((${score} - 10))
    fi
    no=$((${no} + 1))
  done

  echo 'Practice stop.'
}
main
