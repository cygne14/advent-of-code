#!/bin/bash

sum=0
while read -r line; read -r line2; do
  val=$( echo -e "$line\n$line2" | sort -n -t "-" -k 2 -r | sort -n -t "-" -k 1 -s | cut -d "-" -f 2 | tr "\n" "-" | sed "s/-$/\n/" | bc )
  if [ "$val" -ge 0 ]; then
    sum=$(( sum + 1 ))
  fi
done <<< "$( tr "," "\n" < zk )"

echo "$sum"