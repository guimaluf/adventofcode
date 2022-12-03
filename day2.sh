#!/bin/bash

declare -r ROCK=1 PAPER=2 SCISSOR=3
declare -A point=(
  [A]=${ROCK}
  [B]=${PAPER}
  [C]=${SCISSOR}

  [X]=${ROCK}
  [Y]=${PAPER}
  [Z]=${SCISSOR}
)

function jokenpo {
  local -ri LOSE=0 DRAW=3 WIN=6
  local -ri left=${point[${1}]} right=${point[${2}]}

  if (( left == right )); then
    echo -n ${DRAW}
  elif (( left == ROCK && right == SCISSOR )); then
    echo -n ${LOSE}
  elif (( left == SCISSOR && right == ROCK )) ||
       (( left < right )); then
    echo -n ${WIN}
  else
    echo -n ${LOSE}
  fi
}

function jokenpo_with_strategy {
  local LOSE="X" DRAW="Y" WIN="Z"
  local rock="X" paper="Y" scissor="Z"
  local opponent=${1} result=${2}
  local new_me

  if [[ ${result} == ${LOSE} ]] ; then
    case ${point[${opponent}]} in
      ${SCISSOR}) new_me=${paper};;
      ${ROCK})    new_me=${scissor};;
      ${PAPER})   new_me=${rock};;
    esac
  elif [[ ${result} == ${DRAW} ]] ; then
    new_me=${opponent}
  elif [[ ${result} == ${WIN} ]] ; then
    case ${point[${opponent}]} in
      ${SCISSOR}) new_me=${rock};;
      ${ROCK})    new_me=${paper};;
      ${PAPER})   new_me=${scissor};;
    esac
  fi

  echo -n $new_me
}

declare -i results=0 results_p2=0
while read opponent me; do
  results=$(($results + $(jokenpo ${opponent} ${me}) + ${point[${me}]}))

  new_me=$(jokenpo_with_strategy ${opponent} ${me})
  results_p2=$(($results_p2 + $(jokenpo ${opponent} ${new_me}) + ${point[${new_me}]} ))
done

echo $results
echo $results_p2
