# Week 2 — Skill 2: Three-Point Capture

**Name:** Tejaswin Amara · **Roll No.:** `2520090104` · [← Back to Repository Root](../../README.md)

---

## 1. Objective

Construct an isolated three-namespace Linux topology (`host1` — `router` — `host2`), emulate WAN latency and loss (`20ms` delay, `1%` packet loss) via `tc netem`, capture packets simultaneously at three vantage points, and analyze IP TTL decrement, hop-by-hop RTT, and TCP retransmissions.

---

## 2. Network Topology

```text
+-------------------+                  +------------------------------------+                  +-------------------+
|       host1       |  10.0.1.0/30     |               router               |  10.0.2.0/30     |       host2       |
|  10.0.1.1/30      |<---------------->| 10.0.1.2/30            10.0.2.1/30 |<---------------->|  10.0.2.2/30      |
|    (veth-h1)      |                  |  (veth-r1)              (veth-r2)  |                  |    (veth-h2)      |
+-------------------+                  +------------------------------------+                  +-------------------+
        ^                                       ^         [netem: 20ms, 1% loss]                       ^
        |                                       |                                                      |
   [cap1.pcap]                             [cap2.pcap]                                            [cap3.pcap]
```

---

## 3. Execution Workflow

```bash
# 1. Create namespaces and veth pairs
sudo ip netns add host1 && sudo ip netns add router && sudo ip netns add host2
sudo ip link add veth-h1 type veth peer name veth-r1
sudo ip link add veth-r2 type veth peer name veth-h2
sudo ip link set veth-h1 netns host1
sudo ip link set veth-r1 netns router && sudo ip link set veth-r2 netns router
sudo ip link set veth-h2 netns host2

# 2. Assign /30 IPv4 addresses, enable forwarding, and add static routes
sudo ip netns exec host1 ip addr add 10.0.1.1/30 dev veth-h1 && sudo ip netns exec host1 ip link set veth-h1 up
sudo ip netns exec router ip addr add 10.0.1.2/30 dev veth-r1 && sudo ip netns exec router ip addr add 10.0.2.1/30 dev veth-r2
sudo ip netns exec router ip link set veth-r1 up && sudo ip netns exec router ip link set veth-r2 up
sudo ip netns exec host2 ip addr add 10.0.2.2/30 dev veth-h2 && sudo ip netns exec host2 ip link set veth-h2 up
sudo ip netns exec router sysctl -w net.ipv4.ip_forward=1
sudo ip netns exec host1 ip route add 10.0.2.0/30 via 10.0.1.2
sudo ip netns exec host2 ip route add 10.0.1.0/30 via 10.0.2.1

# 3. Apply 20ms delay and 1% loss on router egress (veth-r2)
sudo ip netns exec router tc qdisc add dev veth-r2 root netem delay 20ms loss 1%

# 4. Simultaneous 3-point capture & Netcat TCP message transfer on port 1234
sudo ip netns exec host1 tshark -i veth-h1 -w /tmp/cap1.pcap &
sudo ip netns exec router tshark -i veth-r1 -w /tmp/cap2.pcap &
sudo ip netns exec host2 tshark -i veth-h2 -w /tmp/cap3.pcap &
sudo ip netns exec host2 nc -l 1234 &
sudo ip netns exec host1 nc 10.0.2.2 1234
```

---

## 4. Observation Tables

### Connectivity, Latency & Capture Summary

| Metric | Observed Result |
| --- | --- |
| **Baseline Ping (`host1` → `host2`)** | `TTL = 63` (1 router hop), RTT `min/avg/max = 0.043/0.048/0.052 ms`, `0%` loss |
| **Traffic Control (`veth-r2`)** | `qdisc netem` configured with `delay 20ms loss 1%` |
| **Capture Sizes & Packet Counts** | `cap1.pcap`: `13` pkts (`1.7K`) · `cap2.pcap`: `13` pkts (`1.7K`) · `cap3.pcap`: `14` pkts (`1.7K`) |
| **`mtr` Hop 1 (`10.0.1.2` — Router)** | Avg RTT: `0.1 ms` · Packet Loss: `0.0%` |
| **`mtr` Hop 2 (`10.0.2.2` — `host2`)** | Avg RTT: `20.3 ms` (reflects `20ms` `netem` egress delay) · Packet Loss: `0.0%` |
| **Wireshark TCP Trace (`tcp.port == 1234`)** | ~`20.5 ms` SYN/SYN-ACK RTT; `TCP Retransmission` & `TCP Dup ACK` observed under `1%` loss |

### IP TTL Distribution Across Vantage Points (`sort | uniq -c`)

| Capture File | Vantage Point | Interface | Observed TTL Counts | Routing Behavior |
| --- | --- | --- | --- | --- |
| `cap1.pcap` | `host1` | `veth-h1` | `4` pkts @ `TTL = 64`, `3` pkts @ `TTL = 63` | Outbound frames originate at `64`; return ACKs arrive decremented to `63`. |
| `cap2.pcap` | `router` | `veth-r1` | `4` pkts @ `TTL = 64`, `3` pkts @ `TTL = 63` | Ingress from `host1` is `64` prior to forwarding; return traffic is `63`. |
| `cap3.pcap` | `host2` | `veth-h2` | `4` pkts @ `TTL = 63`, `3` pkts @ `TTL = 64` | Frames from `host1` arrive decremented to `63`; `host2` replies originate at `64`. |

---

## 5. Folder Artifacts

| File | Type | Size |
| --- | --- | --- |
| [`CNNP_Skill2.pdf`](./CNNP_Skill2.pdf) | PDF | 3,961,040 bytes |
| [`cap1.pcap`](./cap1.pcap) | Packet capture — host1 | 2,104 bytes |
| [`cap2.pcap`](./cap2.pcap) | Packet capture — router | 2,104 bytes |
| [`cap3.pcap`](./cap3.pcap) | Packet capture — host2 | 2,332 bytes |