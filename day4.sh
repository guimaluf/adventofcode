#!/bin/bash

declare -i sum=0 overlap=0
while IFS=, read elf1 elf2 ; do
  # Part1
  sections1="$(eval echo {${elf1/-/..}})"
  sections2="$(eval echo {${elf2/-/..}})"

  if [[ " ${sections1} " =~ " ${sections2} " ]] ||
     [[ " ${sections2} " =~ " ${sections1} " ]] ; then
       ((sum++))
  fi

  # Part2
  unset IFS
  s1=(${sections1})
  s2=(${sections2})

  contains=$(comm -12 \
    <(printf "%s\n" "${s1[@]}" | sort) \
    <(printf "%s\n" "${s2[@]}" | sort))
  if [[ -n ${contains} ]]; then
    ((overlap++))
  fi
done

echo $sum
echo $overlap
