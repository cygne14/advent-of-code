#!/bin/bash

datastream=$( cat vstup6 )

for i in $( seq "${#datastream}" ); do
  x=$( grep -o . <<< "${datastream:$i:14}" | sort | tr -d "\n" | tr -s '[:lower:]' )

  if [ "${#x}" == 14 ]; then
    echo $(( i + 14 ))
    break
  fi
done