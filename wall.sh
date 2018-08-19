#!/bin/bash

read sentence

for user in `w -h | awk '{print $2}'`;do
    echo "`who am i`" >> "/dev/"$user
    echo $sentence >> "/dev/"$user
done
