#!/bin/bash


ping -c 1 114.114.114.114 > /dev/null 2>&1

if [ $? -eq 0 ];then
    echo 'ping success'
    cd ~/shell/
    echo 'cd success'
    if [ ! -f update.log  ];then
        touch update.log
    fi
    echo -e "\nauto update: `date`\n" >> update.log
    echo `git log -1` >> update.log
    git add *
    git commit -m "auto update"
    git push -u origin master
else
    echo -e "\nInternet connection failed:  `date`\n" >> update.log
fi
