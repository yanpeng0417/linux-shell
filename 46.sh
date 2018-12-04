#!/bin/bash
ip add |grep '^[0-9]'| awk  -F ': ' '{print $2}' > /tmp/ifs.txt
get_ip()
{
ip add show dev $1 |grep 'inet ' |awk '{print $2}'|awk -F '/' '{print $1}'
}
for eth in `cat /tmp/ifs.txt`
do
   myip=`get_ip $eth`
   if [ -z "$myip" ]
   then 
       echo $eth
   else
       echo $eth $myip
   fi
done > /tmp/if_ip.txt

if [ $# -ne 2 ]
then 
    echo "请输入正确格式: bash $0 -i 网卡 或者 bash $0 -I ip"
    exit
fi

if [ $1 == "-i" ]
then
    if awk '{print $1}' /tmp/if_ip.txt|grep -qw $2
    then
       eth=$2
       ip1=`awk -v aeth=$eth '$1==aeth' /tmp/if_ip.txt|sed "s/$eth //"`
       echo "网络$2 的ip是$ip1"
    else
        echo "你输入的网卡不存在,系统网卡有 `cat /tmp/ifs.txt|xargs`"
    fi
elif [ $1 == "-I" ]
then
    if grep -qw "$2" /tmp/if_ip.txt
    then 
       eth=`grep -w "$2" /tmp/if_ip.txt |awk '{print $1}'`
       echo "IP $2 对应的网卡是 $eth "
    else
       echo "你输入的IP不存在,系统IP有 `ip add |grep 'inet ' |awk '{print $2}'|awk -F '/' '{print $1}'`"
    fi
else
    echo "请输入正确格式: bash $0 -i 网卡 或者 bash $0-I ip"
    exit
fi
       
       
