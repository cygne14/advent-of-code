#!/bin/bash


[ -z "$1" ] && exit 1

# script for download input - one parameter indicating what day to download
curl -v --cookie "session=53616c7465645f5faf242e87db88ffa70f2622f1902e2993823aedcd0bbbff168bf0173ebe6f77cc107b74f52bf1d2fdcc22fa4025db2074e0c1bfd5b0105c37" "https://adventofcode.com/2022/day/$1/input"
