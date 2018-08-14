#!/bin/bash


filename=""

max=0
maxline=""
maxfile=""


list(){
    for temp in $1/*;do
        echo ".$temp"       #打印文件与目录
        if [  -d "$temp"  ]; then   #判断文件夹

            list $temp

        else
            #比较文件大小
            cache=`du -k $temp | awk '{print $1}'`
            if [ $cache -gt 1024 ];then
                continue;
            fi


            #逐行比较字符串长度
            words=`cat $temp`
            for line in $words;do
                len=${#line}
                if [ $len -gt $max ];then
                    maxfile=$temp
                    max=$len
                    maxline=$line
                fi
            done

        fi
    done
}


while read filename;do
    list $filename
    echo "最长文件为 .$maxfile ,最长句子为 $maxline ,长度为 $max "
done
