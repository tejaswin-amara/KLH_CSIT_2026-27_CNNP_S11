# Computer Networks & Network Protocols (CNNP) — Lab Portfolio

![Course](https://img.shields.io/badge/Course-CNNP%20(2026--27)-0A66C2?style=flat-square)
![University](https://img.shields.io/badge/University-KLH%20University-1E293B?style=flat-square)
![Environment](https://img.shields.io/badge/Platform-Ubuntu%20WSL2%20%7C%20Wireshark%20%7C%20Linux%20Netns-2EA44F?style=flat-square)

| Student Name | Roll Number | Branch & Section | Repository |
| :--- | :--- | :--- | :--- |
| **Tejaswin Amara** | `2520090104` | CSIT — S11 | [KLH_CSIT_2026-27_CNNP_S11](https://github.com/tejaswin-amara/KLH_CSIT_2026-27_CNNP_S11) |

---

## Lab Index

| Week | Experiment / Skill | Core Tools & Concepts | Documentation |
| :--- | :--- | :--- | :--- |
| **Week 1** | **Skill 1: Encapsulation Builder** | `tshark`, Wireshark, TCP/UDP/ICMP filters, Layer 2–4 headers | [View `Week-1/README.md`](./Week-1/README.md) |
| **Week 2** | **Skill 2: Three-Point Capture** | `ip netns`, `veth`, `tc netem`, Netcat, `mtr`, TTL & retransmissions | [View `Week-2/README.md`](./Week-2/README.md) |
| **Week 3** | **Skill 3: Queueing Curve & Little's Law** | `tc tbf` (5 Mbps), `iperf3`, bufferbloat analysis, $L = \lambda \times W$ | [View `Week-3/README.md`](./Week-3/README.md) |

---

## Quick Reproduction Environment

All experiments were executed on **Ubuntu (WSL2)** using Linux network namespaces (`iproute2`), traffic control (`tc`), `iperf3`, `mtr`, `tshark`, and **Wireshark**.