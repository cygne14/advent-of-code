#!/bin/bash

cat vstup2 | sed 's/A X/0+3/g' | sed 's/A Y/3+1/g' | sed 's/A Z/6+2/g' | sed 's/B X/0+1/g' | sed 's/B Y/3+2/g' | sed 's/B Z/6+3/g' | sed 's/C X/0+2/g' | sed 's/C Y/3+3/g' | sed 's/C Z/6+1/g' | bc | tr "\n" "+" | sed 's/+$/\n/' | bc
