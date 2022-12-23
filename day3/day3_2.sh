#!/bin/bash


sum=0
for i in $( while read -r line; read -r line2; read -r line3; do
     aaa=$( echo "$line2" | tr -cd "$line" | tr -s "a-zA-Z" )
     echo "$line3"| tr -cd "$aaa" | tr -s "a-zA-Z"
done < vstup3 | sed "s/./& /g" ); do
  val=$( echo -n "$i" | od -An -tuC )

  if [[ $i == [a-z] ]]; then
    sum=$(( sum + val - 96 ))
  else
    sum=$(( sum + val - 38 ))
  fi

done

echo "$sum"