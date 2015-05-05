#!/bin/sh
#归档当天的数据，到today目录
rdb_file="/usr/local/var/db/redis/dump.rdb";
if [ ! -r $rdb_file ];then
  echo 'rdb_file:'$rdb_file"不存在";
fi
target_dir='/tmp/redis_backup';
if [ ! -d $target_dir  ]; then
  echo 'target_dir:'$target_dir"不存在";
  exit;
fi
hour=`date +'%H'`;
#创建目录today
today_dir=$target_dir"/today";
if [ ! -d $today_dir  ]; then
  mkdir $today_dir;
fi
#每小时备份
cp $rdb_file  $today_dir"/hour_"$hour".rdb";

#每天备份一次
#创建目录guidang
guidang_dir=$target_dir"/guidang";
if [ ! -d $guidang_dir  ]; then
  mkdir $guidang_dir;
fi
if [ $hour == 0 ];then
  date=`date +%Y-%m-%d`;
  cp $rdb_file  $guidang_dir"/day_""$date"".rdb";
fi
#rsync同步
