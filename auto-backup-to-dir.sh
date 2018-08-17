#!/bin/bash

. /home/max/.backup.rc

DATE=`date +%Y-%m-%d_%H.%M.%S`

if [ ! -f "$BACKUP_LOG_PATH" ];then  
    `touch "$BACKUP_LOG_PATH"`
    echo "日期    　             命令     对象　　                                                   　文件变化大小" >> $BACKUP_LOG_PATH 
fi


for path in `echo $BACKUP_PATH|tr ":" "\n"`;do
    cd $path
    str=`echo "$path"|tr "/" "_"`
    if [ ! -d "${DEST_DIR}$str"  ];then
        mkdir ${DEST_DIR}$str
    fi
    tar -cf ""${DATE}".tar"  *
    last=`ls -t $DEST_DIR$str|head -n 1`
    last_size=0
    if [  -f ${DEST_DIR}${str}/$last ];then
        last_size=`du -k ${DEST_DIR}${str}/$last | awk '{print $1}'`
    fi
    size=`du -k ""${DATE}".tar" | awk '{print $1}'`
    size=$[$size-$last_size]
    mv ""${DATE}".tar" $DEST_DIR$str
    color=0
    if [ $size -gt 0 ];then
        color=32
    fi
    if [ $size -lt 0 ];then
        color=31
    fi
    echo -e "$DATE    ADD      "${DEST_DIR}${str}/${DATE}.tar"      \033[${color}m$size K \033[0m"  >>$BACKUP_LOG_PATH
    del_list=`find ${DEST_DIR}${str} -name "*.tar" -mtime +3`
    for i in $del_list;do
        rm -f $i
        echo -e "$DATE    \033[44mDELETE \033[0m       $i" >>$BACKUP_LOG_PATH
    done
done


