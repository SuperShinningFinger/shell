#!/bin/bash
declare -a arry
date=`date +'%Y-%m-%d__%H:%M:%S'`
j=1
arry[0]=$date
for i in `free -m | grep "Mem" | awk '{printf("%s %s",$2,$4)}'`;do
    arry[j]=$i
    j=$[$j+1]
done
arry[3]=`echo "scale=1;(${arry[1]}-${arry[2]})/${arry[1]}*100"|bc`
arry[4]=`echo "scale=1;0.3*$1+0.7*${arry[3]}"|bc`
for (( i=0;i<5;i++ ));do
    echo -e "${arry[$i]}\t\c"
done
echo -e "\n"

