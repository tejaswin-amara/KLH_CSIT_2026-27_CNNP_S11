#!/usr/bin/env bash
set -e
# Skill 3: Queueing Curve, Little's Law & Buffer Analysis (5 Mbps TBF Bottleneck)
sudo ip netns add sender && sudo ip netns add router && sudo ip netns add receiver
sudo ip link add veth-s type veth peer name veth-r0
sudo ip link add veth-r1 type veth peer name veth-r
sudo ip link set veth-s netns sender
sudo ip link set veth-r0 netns router && sudo ip link set veth-r1 netns router
sudo ip link set veth-r netns receiver
sudo ip netns exec router ip link set veth-r0 name eth0
sudo ip netns exec router ip link set veth-r1 name eth1

sudo ip netns exec sender ip addr add 192.168.10.2/24 dev veth-s && sudo ip netns exec sender ip link set veth-s up && sudo ip netns exec sender ip link set lo up
sudo ip netns exec router ip addr add 192.168.10.1/24 dev eth0 && sudo ip netns exec router ip addr add 192.168.20.1/24 dev eth1
sudo ip netns exec router ip link set eth0 up && sudo ip netns exec router ip link set eth1 up && sudo ip netns exec router ip link set lo up
sudo ip netns exec receiver ip addr add 192.168.20.2/24 dev veth-r && sudo ip netns exec receiver ip link set veth-r up && sudo ip netns exec receiver ip link set lo up

sudo ip netns exec router sysctl -w net.ipv4.ip_forward=1
sudo ip netns exec sender ip route add 192.168.20.0/24 via 192.168.10.1
sudo ip netns exec receiver ip route add 192.168.10.0/24 via 192.168.20.1
sudo ip netns exec router tc qdisc replace dev eth1 root tbf rate 5mbit burst 32kb limit 64kb
