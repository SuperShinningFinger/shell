#!/bin/bash

date=`date +"%Y-%m-%d__%H:%M:%S"`
uid=`cat /etc/passwd | cut -d ':' -f 3|tr ' ' '\n'`
total=0
for i in $uid;do
    if [ $i -gt 1000 ];then
        total=$[$total+1]
    fi
done

active_user=`last | grep  ' ' | grep -v "wtmp"|grep -v "shutdown"|grep -v "running"|grep -v "logged"|cut -d " " -f 1|sort|uniq -c|sort -r|tr '0-9' ' '`

declare -a active_arr
j=0
for i in $active_user;do
    active_arr[j]=$i
    if [ $j -eq 2 ];then
        break;
    fi
    j=$[$j+1]
done


declare -a sudo_arr
j=0
user_name=`cat /etc/passwd | cut -d ':' -f 1|tr ' ' '\n'`
for i in $user_name;do
    auth=`groups $i`
    auth=$auth|tr ' ' '\n'
    flag=0
    for k in $auth;do
        if [ $k == ":" ];then
            flag=1;
        fi
        if [ $flag -eq 0  ];then
            continue;
        fi
        if [ $k == ":"  ];then
            continue;
        fi
        if [ $k == "sudo"  ];then
            sudo_arr[j]=$i
        fi
    done
done


online_user=`w -s -h | awk '{print $1"_"$3"_"$2","}'`


echo -e "$date\t$total\t[${active_arr[0]}\c"
i=1
while [ $i -lt 3 ];do
    echo -e ",${active_arr[$i]}\c"
    i=$[$i+1]
done
echo -e "]\t[${sudo_arr[0]}\c"
i=1
while [ $i -le $j ];do
    echo -e ",${sudo_arr[$i]}\c"
    i=$[$i+1]
done
echo -e "]\t[\c"
online_user=${online_user%?}
for i in $online_user;do
    echo -e "$i\c"
done
echo -e "]\n"



