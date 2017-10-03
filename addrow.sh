#!/bin/bash
#
# Insert row to data table written in csv format.
# arg1: destination file
# arg2: source file

error() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}

main() {
  if [[ $# != 2 ]]; then
    error 'argument count is too small.'
    exit
  fi
  local dst=${1}
  local src=${2}
  local max=$(echo "$(wc -l ${src})" | sed -e 's/\(.*\)\ \(.*\)/\1/g')
  for i in $(seq 1 ${max}); do
    local dst_str=$(sed -n "${i}p" ${dst})
    local src_str=$(sed -n "${i}p" ${src})
    echo "${dst_str} ${src_str}"
  done
}

main ${1} ${2}
