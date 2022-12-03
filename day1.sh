#!/bin/bash

declare -a elves
declare -i calory

elf=0
max_elf=0

while read calory ; do
  if (( calory == 0  )); then
    elves[$((++elf))]=0
  fi

  elves[${elf}]=$((elves[${elf}] + calory))
done

printf '%s\n' "${elves[@]}" | sort -nr | head -n1
printf '%s+%s+%s\n' $(printf '%s\n' "${elves[@]}" | sort -nr | head -n3 ) | bc
