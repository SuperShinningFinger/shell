#!/bin/bash

IP=192.168

for i in {1,2};do
    for j in `seq 40 49`;do
        ping -c $IP.$i.$j > /dev/null 2>&1
        if [ $? -eq 0 ];then
            echo "$IP.$i.$j is online"
        else
            echo "$IP.$i.$j is offline"
        fi
    done
done
