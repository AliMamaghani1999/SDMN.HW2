#!/bin/bash
str1=$2
str2=node1
 
if [ "$str1" == "$str2" ]; then
    ipp=172.0.0.2
fi
str2=node2
if [ "$str1" == "$str2" ]; then
    ipp=172.0.0.3
fi
str2=node3
if [ "$str1" == "$str2" ]; then
    ipp=10.10.0.2
fi
str2=node4
if [ "$str1" == "$str2" ]; then
    ipp=10.10.0.3
fi
str2=router
if [ "$str1" == "$str2" ]; then
    ipp=10.10.0.1
fi

sudo ip netns exec $1 ping $ipp