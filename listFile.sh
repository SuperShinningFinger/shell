#!/bin/bash


#查找指定文件夹中的目录个数与文件个数
#search the num of dir and files

START_PATH=~/TEST

file_num=0
box_num=0

function list()
{
   for file in `ls -a $1`;do
       # 判断是否为文件夹可用ls的文件名加上工作目录前缀
      if [ -d "$1"/"$file"  ];then
        if [[ "$file" == "." || "$file" == ".." ]];then
            continue;
        else
            box_num=$[$box_num+1]
            list $1"/"$file
        fi
      else
        file_num=$[$file_num+1]
      fi
  done
}
list $START_PATH
echo "file_num=$file_num"
echo "box_num=$box_num"
