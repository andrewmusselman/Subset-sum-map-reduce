#!/bin/bash
echo "Removing output directories if they exist"
rm o*
./generate-numbers.py
i=0
#for num in 1 -10 6 5 7 -8 -1 -6
cat rns | while read num
do
  j=$((i+1))
  if [ $i -ne 0 ]
  then
    cat o$i | ./map.py $num > o$j
  fi
  echo -n ${num#-}':'$num':'$num >> o$j
  sort -n -k1,1 o$j > t$j
  mv t$j o$j
  is_zero=$(grep ^0 o$j)
  if [ $? -eq 0 ]
  then
    grep ^0 o$j
    exit 0
  fi
  i=$j
done
