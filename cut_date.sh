#/bin/sh

file=`\ls -l $1`
temp=`\echo ${file} | \cut -d " " -f 6-8`
echo `\echo ${temp} | \sed 's/\ /-/g'`
