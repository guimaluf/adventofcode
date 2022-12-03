#!/bin/bash

declare -A priority
for j in {a..z} {A..Z}; do
  priority[$j]=$((++i))
done

declare -a elf_group
while read rucksack; do
  elf_group+=(${rucksack})
  (( ${#elf_group[@]} < 3 )) && continue

  item=${elf_group[0]//[^${elf_group[1]}]/}
  item=${item//[^${elf_group[2]}]/}

  printf "%s %s %s\n" ${elf_group[@]} ${item} ${priority[${item::1}]}

  sum=$((sum + ${priority[${item::1}]}))
  (( ${#elf_group[@]} == 3 )) && elf_group=()
done

echo $sum
