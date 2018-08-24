#!/bin/bash 
if [ -f test.log  ];then
    rm test.log
fi
echo "ABCefg" >> test.log
str=`cat test.log`
str=`echo $str|tr  'A-Z' 'a-z'`
echo $str
