#!/bin/bash
./generate-numbers.py
touch o0
hadoop fs -put o0 o0
i=0
#for num in 1 -10 6 
cat rns | while read num
do
  j=$((i+1))
  time hadoop jar $HADOOP_HOME/contrib/streaming/hadoop-streaming-0.20.203.0.jar -input o$i -output m$j -mapper `pwd`"/map-hs.py $num" -reducer "/usr/bin/sort -n"
  time hadoop jar $HADOOP_HOME/contrib/streaming/hadoop-streaming-0.20.203.0.jar -input m$j -output o$j -mapper /bin/cat -reducer /usr/bin/uniq
  hadoop fs -rmr m$j
  hadoop fs -rmr o$i
  is_zero=$(hadoop fs -cat o$j/part-00000 | grep ^0)
  if [ $? -eq 0 ]
  then
    hadoop fs -cat o$j/part-00000 | grep ^0
    exit 0
  fi
  i=$j
done
