#!/bin/bash
date=`date +"%Y-%m-%d__%H:%M:%S"`
load=`uptime`
load=`echo $load|awk '{printf("%s %s %s",$8,$9,$10)}'`
load=`echo $load|tr -d ','|tr ' ' '\t'`
cpu_heat=`sensors | grep " " |grep "temp1"|head -n 1|awk '{printf $2}'`
cpu_heat=${cpu_heat#*+}
cpu_heat=${cpu_heat%°*}
if [ $(echo "${cpu_heat}<50"|bc) -eq 1 ];then
    level="normal"
elif [ $(echo "$cpu_heat<70"|bc) -eq 1 ];then
    level="note"
else
    level="warning"
fi
cpu_per=`cat /proc/stat | head -n 1 | awk '{printf("%s+%s+%s+%s+%s+%s+%s+%s+%s",$2,$3,$4,$5,$6,$7,$8,$9,$10)}'`
cpu_total1=$[$cpu_per]
idle1=`cat /proc/stat | head -n 1 | awk '{printf("%s",$5)}'`
`sleep 0.5`
cpu_per=`cat /proc/stat | head -n 1 | awk '{printf("%s+%s+%s+%s+%s+%s+%s+%s+%s",$2,$3,$4,$5,$6,$7,$8,$9,$10)}'`
cpu_total2=$[$cpu_per]
idle2=`cat /proc/stat | head -n 1 | awk '{printf("%s",$5)}'`
cpu_total=$[$cpu_total2-$cpu_total1]
cpu_used=`echo "scale=1;100*($idle2-$idle1)/$cpu_total"|bc`

echo -e "$date\t$load\t$cpu_used%\t$cpu_heat\t$level\n"

