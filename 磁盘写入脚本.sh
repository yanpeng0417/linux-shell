#!/bin/bash
d=`date +%F`
dir=/data/logs/disklod
if [ ! -d $dir ]
  then
     mkdir -p $dir
fi

df -h < $d.log
find $dir/ -mtime +365 |xargs rm -rf
