#!/bin/bash

TRASH_PATH=~/trash/  # 回收站位置


if [ ! -n "$1" ];then
    echo "缺少必要的参数: rm [-r] [-f] [-rf] filename"
    exit 1
fi


# 删除空文件夹与单个文件
if [ ! -n "$2"  ];then
    echo "正在删除 $2 "
    if [[ -d "$1" &&  `ls $1`   ]];then
        echo "试图删除非空文件夹,请用 rm -r 删除"
        exit 1
    fi
fi

level=0; 


# 是否有-r选项的标记
if [[ $1 = -r || $2 = -r ]];then
    level=$[$level+1]
fi

# 是否有-f选项的标记
if [[ $1 = -f || $2 = -f ]];then
    level=$[$level+2]
fi

# 是否有-rf选项的标记
if [[ $1 != -r && $2 != -r && $q != -f && $2 != -f && ($1 = "-rf" || $2 = "-rf") ]];then
    level=3
fi

# 根据选项进行-r或-f的删除,考虑到同名文件夹覆盖问题,获取删除时的系统时间作为新的文件夹名
for i in $@;do
    echo "正在删除 $i "
    nowtime=$(date "+%Y-%m-%d_%H:%M:%S")
    path=${TRASH_PATH}${nowtime}
    if [[ ! -d "$path"  ]];then
        mkdir $path
    fi
    if [[ $i = -r || $i = -f || $i = "-rf"  ]];then
        continue;
    fi
    case $level in
        0) mv -i $i $path;;
        1) mv -i $i $path;;
        2) if [[ -d "$i" &&  `ls $i`   ]];then
            echo "试图删除非空文件夹,请用 rm -r 删除"
        fi 
        exit 1
        mv -f -b $i $path;;
    3) mv -f -b $i $path;;
    esac
done
