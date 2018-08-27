#!/bin/bash 
date=`date +"%Y-%m-%d__%H:%M:%S"`
name=`uname -n`
os=`uname -o`
kernel=`uname -r`
uptime=`uptime -p`
uptime=`echo $uptime|tr ' ' "_"`
load=`uptime`
load=`echo $load|awk '{printf("%s %s %s",$8,$9,$10)}'`
load=`echo $load|tr -d ','|tr ' ' '\t'`
detail=`df | tail |grep -v "tmpfs"|awk '{printf("total=%s;rest=%s;percent=%s\n",$2,$4,$5)}'`
disk_total=0
disk_rest=0
disk_percent=0
for i in $detail;do
    eval $i
    total=$[$total/1024]
    disk_total=$[$disk_total+$total]
    rest=$[$rest/1024]
    disk_rest=$[$rest+$disk_rest]
done
disk_percent=`echo "scale=1;($disk_total-$disk_rest)/$disk_total*100"|bc`
cpu_heat=`sensors | grep " " |grep "temp1"|head -n 1|awk '{printf $2}'`
declare -a level

if [ $(echo "$disk_percent<80"|bc) -eq 1 ];then
    level[0]="normal"
elif [ $(echo "$disk_percent<90"|bc) -eq 1 ];then
    level[0]="note"
else
    level[0]="warning"
fi

mem=`free|tail`
mem_total=`echo $mem| grep "Mem" | awk '{print $8}'`
mem_used=`echo $mem| grep "Mem" | awk '{print $9}'`

mem_percent=`echo "scale=1;$mem_used/$mem_total"|bc`
if [ $(echo "${mem_percent}<70"|bc) -eq 1 ];then
    level[1]="normal"
elif [ $(echo "${mem_percent}<80"|bc) -eq 1 ];then
    level[1]="note"
else
    level[1]="warning"
fi
cpu_heat=${cpu_heat#*+}
cpu_heat=${cpu_heat%°*}

if [ $(echo "${cpu_heat}<50"|bc) -eq 1 ];then
    level[2]="normal"
elif [ $(echo "$cpu_heat<70"|bc) -eq 1 ];then
    level[2]="note"
else
    level[2]="warning"
fi

echo -e "$date\t$name\t$os\t$kernel\t$uptime\t$load\t${disk_total}M\t$disk_percent%\t$cpu_heat°C\t${level[0]}\t${level[1]}\t${level[2]}\n"

