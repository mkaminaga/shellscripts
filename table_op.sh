#!/bin/bash
# author: Mamoru Kaminaga
# date:   2017/10/03

NAME=$(basename "${0}")
ARGNUE=${#}
COMMAND=${1}
ARG1=${2}
ARG2=${3}
ARG3=${4}
ARG4=${5}

COMMAND_LIST=('add_table' 'div_table' 'get_row' '-help')
HELP="
${NAME}
Usage: ${NAME} [COMMAND] [ARG1] [ARG2]...
  COMMAND: ${COMMAND_LIST[0]}
    ARG1: The input file 1.
    ARG2: The input file 2.
    ARG3: The output file.
    Adds table in the input file 1 to another table in the input file 2.
    The outcome is written to the output file.
  COMMAND: ${COMMAND_LIST[1]}
    ARG1: The input file.
    ARG2: The output file 1.
    ARG3: The output file 2.
    ARG4: The row to be the first line of the output file 2.
    Divides the table in the input file into the output file 1 and 2.
    The row in the input file is to be the first raw of the output file 2.
  COMMAND: ${COMMAND_LIST[2]}
    ARG1: The input file.
    ARG2: The output file.
    ARG3: The row number to be extracted.
    Extracts the specific line from the input file.
    The row is specified.
  COMMAND: ${COMMAND_LIST[3]}
    What you are reading now.
"
error() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}
add_table() {
  if [[ ${#} != 3 ]]; then
    error 'argument error.'
    exit
  fi
  local in1=${ARG1}
  local in2=${ARG2}
  local out=${ARG3}
  # Column numbers are checked.
  local col1=$(echo "$(wc -l ${in1})" | sed -e 's/\(.*\)\ \(.*\)/\1/g')
  local col2=$(echo "$(wc -l ${in2})" | sed -e 's/\(.*\)\ \(.*\)/\1/g')
  if [[ ${col1} != ${col2} ]]; then
    error 'column num mismatch'
    exit
  fi
  # New table is created.
  local new_rows=()
  for i in $(seq 1 ${col1}); do
    local part1=$(sed -n "${i}p" ${in1})
    local part2=$(sed -n "${i}p" ${in2})
    new_rows+=("$(echo -e "${part1} ${part2}")")
  done
  # New table is expoted.
  : > ${out}
  for i in $(seq 1 ${col1}); do
    echo ${new_rows[i]} >> ${out}
  done
}
div_table() {
  if [[ ${#} != 4 ]]; then
    error 'argument error.'
    exit
  fi
  local in=${ARG1}
  local out1=${ARG2}
  local out2=${ARG3}
  local row=${ARG4}
}
get_row() {
  if [[ ${#} != 3 ]]; then
    error 'argument error.'
    exit
  fi
  local in=${ARG1}
  local out=${ARG2}
  local row=${ARG3}
}
show_help() {
  echo "${HELP}"
}
main() {
  if [[ "${COMMAND}" = "${COMMAND_LIST[0]}" ]]; then
    add_table ${ARG1} ${ARG2} ${ARG3}
  elif [[ "${COMMAND}" = "${COMMAND_LIST[1]}" ]]; then
    div_table ${ARG1} ${ARG2} ${ARG3} ${ARG4}
  elif [[ "${COMMAND}" = "${COMMAND_LIST[2]}" ]]; then
    get_row ${ARG1} ${ARG2} ${ARG3}
  elif [[ "${COMMAND}" = "${COMMAND_LIST[3]}" ]]; then
    show_help
  else
    error 'Invalid command'
  fi
}

main ${1} ${2}
