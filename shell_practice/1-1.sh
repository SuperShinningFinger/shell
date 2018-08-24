#!/bin/bash
str='1 2 3 4 5 6 7 9 a v 你好 . /8'
sum=0
str=`echo $str|$[$(tr -c '0-9' '+')0]`
for i in $str;do
    if [[ $i  ]];then
        sum=$[$sum+$i]
    fi
done
echo $sum

