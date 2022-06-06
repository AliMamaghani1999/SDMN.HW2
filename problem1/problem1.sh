#!/bin/bash
sudo ip -all netns delete
sudo ip link delete vbr1
sudo ip link delete vbr2
sudo ip netns add node1
sudo ip netns add node2
sudo ip netns add node3
sudo ip netns add node4
sudo ip netns add router


sudo ip link add veth0-n1 type veth peer name veth0-br1
sudo ip link add veth0-n2 type veth peer name veth1-br1
sudo ip link add veth0-n3 type veth peer name veth0-br2
sudo ip link add veth0-n4 type veth peer name veth1-br2

sudo ip link add veth0-r type veth peer name veth2-br1
sudo ip link add veth1-r type veth peer name veth2-br2

sudo ip link add vbr1 type bridge 
sudo ip link add vbr2 type bridge 
sudo ip link set dev vbr1 up
sudo ip link set dev vbr2 up



sudo ip link set veth0-n1 netns node1
sudo ip link set veth0-n2 netns node2
sudo ip link set veth0-n3 netns node3
sudo ip link set veth0-n4 netns node4

sudo ip link set veth0-r netns router
sudo ip link set veth1-r netns router

sudo ip link set veth0-br1 master vbr1
sudo ip link set veth1-br1 master vbr1
sudo ip link set veth2-br1 master vbr1
sudo ip link set veth0-br2 master vbr2
sudo ip link set veth1-br2 master vbr2
sudo ip link set veth2-br2 master vbr2


sudo ip -n node1 addr add 172.0.0.2/24 dev veth0-n1
sudo ip -n node2 addr add 172.0.0.3/24 dev veth0-n2
sudo ip -n node3 addr add 10.10.0.2/24 dev veth0-n3
sudo ip -n node4 addr add 10.10.0.3/24 dev veth0-n4 

sudo ip -n router addr add 172.0.0.1/24 dev veth0-r 
sudo ip -n router addr add 10.10.0.1/24 dev veth1-r




sudo ip -n node1 link set veth0-n1 up
sudo ip -n node2 link set veth0-n2 up
sudo ip -n node3 link set veth0-n3 up
sudo ip -n node4 link set veth0-n4 up

sudo ip -n router link set veth0-r up
sudo ip -n router link set veth1-r up

sudo ip link set veth0-br1 up
sudo ip link set veth1-br1 up
sudo ip link set veth2-br1 up
sudo ip link set veth0-br2 up
sudo ip link set veth1-br2 up
sudo ip link set veth2-br2 up


sudo ip -n node1 link set lo up
sudo ip -n node2 link set lo up
sudo ip -n node3 link set lo up
sudo ip -n node4 link set lo up

sudo ip -n router link set lo up



sudo ip netns exec node1 ip route add 10.10.0.0/24 via 172.0.0.1
sudo ip netns exec node2 ip route add 10.10.0.0/24 via 172.0.0.1  
sudo ip netns exec node3 ip route add 172.0.0.0/24 via 10.10.0.1 
sudo ip netns exec node4 ip route add 172.0.0.0/24 via 10.10.0.1 