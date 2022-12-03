#!/bin/bash

declare -A priority

for j in {a..z} {A..Z}; do
  priority[$j]=$((++i))
done

while read rucksack; do
  middle=$((${#rucksack}/2))

  rcks1=${rucksack::${middle}}
  rcks2=${rucksack:${middle}}

  item=${rcks2//[^${rcks1}]/}
  printf "%s %s\n%s %d\n\n" ${rcks1} ${rcks2} ${item} ${priority[${item::1}]}

  sum=$((sum + ${priority[${item::1}]}))
done

echo $sum
