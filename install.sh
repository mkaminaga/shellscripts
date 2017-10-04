#!/bin/bash
SCRIPT=${1}
if [ ${#} != 1 ]; then
  echo "Arg num error" >&2
  exit 1
fi
if [ ! -e ${SCRIPT} ]; then
  echo "No such a script" >&2
  exit 1
fi
INSTALLDIR=/usr/local/bin/
cp ${SCRIPT} ${INSTALLDIR}
chmod uo+x ${INSTALLDIR}/${SCRIPT}
