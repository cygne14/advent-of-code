#!/bin/bash


res=$(
  while read -r line; do
   l="${#line}"
   l=$(( l/2 ))

   first="${line:0:l}"
   second="${line:l}"

   echo "$second" | tr -cd "$first" | tr -s "a-zA-Z"
done < vstup3
)

# shellcheck disable=SC2001
iter=$( echo "$res" | sed "s/./& /g" )

sum=0
for i in $iter; do
   val=$( echo -n "$i" | od -An -tuC )

   if [[ $i == [a-z] ]]; then
     sum=$(( sum + val - 96 ))
   else
     sum=$(( sum + val - 38 ))
   fi
done

echo "$sum"
