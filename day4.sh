#!/bin/bash

declare -i sum=0
while IFS=, read elf1 elf2 ; do
  sections1="$(eval echo {${elf1/-/..}})"
  sections2="$(eval echo {${elf2/-/..}})"

  if [[ " ${sections1} " =~ " ${sections2} " ]] ||
     [[ " ${sections2} " =~ " ${sections1} " ]] ; then
       ((sum++))
  fi
done

echo $sum
