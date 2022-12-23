#!/bin/bash

cat vstup1 | tr "\n" "+" | sed "s/++/\n/g" | sed "s/+$/\n/" | bc | sort -nr | head -n 1
