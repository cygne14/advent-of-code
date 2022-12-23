#!/bin/bash

sum=0
while read -r line; read -r line2; do
  val=$( echo -e "$line\n$line2" | sort -n -t "-" -k 2 -r | sort -n -t "-" -k 1 -s | tr "\n" " " | cut -d "-" -f 2 | tr " " "-" | bc )
  if [ "$val" -ge 0 ]; then
    sum=$(( sum + 1 ))
  fi
done <<< "$( tr "," "\n" < vstup4 )"

echo "$sum"