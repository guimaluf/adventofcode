#!/bin/bash

declare -a cargo[9]
while read ; do
  # echo "$REPLY" "${#REPLY}"

  [[ $REPLY =~ ^\ 1 ]] && continue
  [[ $REPLY =~ ^$ ]] && break

  for i in {0..9}; do
    crate="${REPLY:$((1+4*i)):1}"
    cargo[$i]+=${crate// /}
  done
done

declare -a cargo2p=(${cargo[@]})
re='move ([0-9]+) from ([0-9]) to ([0-9])'
while read; do
  [[ $REPLY =~ $re ]]
  move=${BASH_REMATCH[1]}
  from=$((${BASH_REMATCH[2]}-1))
  to=$((${BASH_REMATCH[3]}-1))

  # echo ${cargo[${from}]}  ${cargo[${to}]}
  # echo $REPLY
  cargo[${to}]=$(rev <<<${cargo[${from}]::${move}})${cargo[${to}]}
  cargo[${from}]=${cargo[${from}]:${move}}

  cargo2p[${to}]=${cargo2p[${from}]::${move}}${cargo2p[${to}]}
  cargo2p[${from}]=${cargo2p[${from}]:${move}}
done

for i in {0..9}; do
  cargo_result+=${cargo[$i]::1}
  cargo2p_result+=${cargo2p[$i]::1}
done
echo ${cargo_result}
echo ${cargo2p_result}
