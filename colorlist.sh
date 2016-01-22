#!/bin/bash

# draw color
for i in {0..255}; do
  str=`printf "%03d" $i`

  # draw sample 256 color num with coresponding forground
  printf " \e[38;05;${i}m${str}\e[m"

  if [ $((${i} % 16)) -eq 15 ];then
    echo
  fi
done
