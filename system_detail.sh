#!/bin/bash

date=`date +"%Y-%m-%d__%H:%M:%S"`
name=`uname -n`
os=`uname -o`
kernel=`uname -r`
echo "os=$os,kernel=$kernel"
