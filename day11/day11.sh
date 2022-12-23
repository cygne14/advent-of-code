#!/bin/bash


sed "/Monkey/d" < "$1" | tr -d "a-zA-Z:=" | tr -d " " | sed "s/^$/@/g" | tr "\n" " " | tr "@" "\n" | sed "s/^ //g"
echo
