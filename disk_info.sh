#!/bin/bash


date=`date +"%Y-%m-%d__%H:%M:%S"`

detail=`df | tail |grep -v "tmpfs"|awk '{printf("name=%s;total=%s;rest=%s;percent=%s\n",$1,$2,$4,$5)}'`
disk_total=0
disk_rest=0
disk_percent=0
for i in $detail;do
    eval $i
    total=$[$total/1024]
    disk_total=$[$disk_total+$total]
    rest=$[$rest/1024]
    disk_rest=$[$rest+$disk_rest]
    echo -e "$date\t1\t$name\t${total}M\t${rest}M\t$percent"
done
disk_percent=`echo "scale=1;($disk_total-$disk_rest)/$disk_total*100"|bc`
echo -e "$date\t0\tdisk\t\t${disk_total}M\t${disk_rest}M\t$disk_percent%"

