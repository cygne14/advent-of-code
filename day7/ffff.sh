#!/bin/bash

a="@cd a"

if [[ "$a" =~ "@cd ".* ]]; then
  echo "AA"
fi