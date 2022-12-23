#!/bin/bash

sum=0
for i in 20 60 100 140 180 220; do
  val=$( sed s"/noop/0/g" < vstup10 | sed "0,/addx/s//0\naddx/" | sed "s/addx \([-0-9]*\)/0\n\1/" | head -n "$i" | tr "\n" "+" | sed "s/+$/\n/" | sed "s/+-/-/g" | sed "s/0/1/" | bc )
  sum=$(( sum + val * i ))
done

echo "$sum"