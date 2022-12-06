#!/bin/bash

declare -a cargo[9]
while read ; do
  # echo "$REPLY" "${#REPLY}"

  [[ $REPLY =~ ^\ 1 ]] && continue
  [[ $REPLY =~ ^$ ]] && break

  for j in {0..9}; do
    crate="${REPLY:$((1+4*j)):1}"
    cargo[$j]+=${crate// /}
  done
done

re='move ([0-9]+) from ([0-9]) to ([0-9])'
while read; do
  [[ $REPLY =~ $re ]]
  move=${BASH_REMATCH[1]}
  from=$((${BASH_REMATCH[2]}-1))
  to=$((${BASH_REMATCH[3]}-1))

  # echo ${cargo[${from}]}  ${cargo[${to}]}
  # echo $REPLY
  for i in $(seq $move); do
    cargo[${to}]=${cargo[${from}]::1}${cargo[${to}]}
    cargo[${from}]=${cargo[${from}]:1}
  done
done

for j in {0..9}; do
  echo -n ${cargo[$j]::1}
done
echo
