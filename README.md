# 🌐 Computer Networks And Network Programming

![Course Code](https://img.shields.io/badge/Course-25CS2208E-blue?style=for-the-badge)
![Credits](https://img.shields.io/badge/Credits-3-brightgreen?style=for-the-badge)
![Trimester](https://img.shields.io/badge/Trimester-T05-orange?style=for-the-badge)
![Category](https://img.shields.io/badge/Category-Project__Based__Learning-purple?style=for-the-badge)
![Prerequisite](https://img.shields.io/badge/Pre--requisite-DMS-red?style=for-the-badge)

> **Structure (L-T-P-S):** `2-0-0-4` | **Contact Hours/Week:** `8`
> **Goal:** Twelve weeks, three interlocking builds, one campus. Design and operate a real internetwork, implement the protocol stack that runs on it, and engineer the network that carries traffic with a deadline.

---

## 🎯 Course Outcomes (COs)

* **`[CO1]` 📊 Analyze:** A network as a measured system—layering and encapsulation, header overhead, MTU, the delay equation, throughput as the min-cut, the queueing-delay curve and its knee, Little's Law, bandwidth-delay product, jitter and percentiles—and account for every microsecond of a transfer with numbers defended from captures rather than described. *(BTL4)*
* **`[CO2]` 🛠️ Create:** Implement the transport and application layers from scratch in C—sockets, framing, an HTTP/1.1 server and a DNS resolver; blocking, select, poll and epoll with backpressure at ten thousand connections; a reassembler, receiver and sender with a derived retransmission timer and fast retransmit; slow start, AIMD and fast recovery checked against the Mathis relation; TLS termination and prove interoperability by a bidirectional 1 MB transfer against an unmodified Linux kernel TCP peer over an impaired link. *(BTL6)*
* **`[CO3]` 🗺️ Apply:** Prefix arithmetic, VLSM, summarisation, IPv6 addressing and DHCP relay, longest-prefix match, ARP, distance-vector and link-state routing, the OSPF convergence budget, route selection, NAT, first-hop redundancy, BGP and overlays to design and bring up a campus internetwork as code with a dual uplink, no black-holing on failover, and convergence after a link failure inside a stated budget. *(BTL3)*
* **`[CO4]` 🔌 Analyze:** The link and physical layers—the frame and what the FCS guarantees, CRC over GF(2), MAC learning, VLANs and trunks, spanning tree and the loop with no brake, link aggregation and its hashing problem, media budgets, Shannon and Nyquist; the RF link budget, CSMA/CA and the hidden node, SNR to data rate, airtime as the real resource, roaming, and constrained low-power links and diagnose faults that produce no error message. *(BTL4)*
* **`[CO5]` 🛡️ Evaluate:** Operate what was built—the formalised troubleshooting methodology (problem statement, falsifiable hypothesis and test, elimination, evidence, one-change fix, verification), observability and availability arithmetic, ACLs and stateful firewalls where order is policy, identity at the edge and zero trust, VPN MTU cost, token-bucket rate limiting, and idempotent Ansible automation—root-causing Fault Bank faults within a time limit with a complete hypothesis-test-evidence fix-verify log. *(BTL5)*
* **`[CO6]` ⏱️ Create:** Engineer and defend a latency and jitter budget for time-sensitive traffic—jitter and the playout buffer, queue disciplines and what each actually bounds, DiffServ marking, policing and shaping, media bandwidth and the E-model, multicast and group management, and PTP clock synchronisation—measured as p50/p99 distributions under sustained contention against stated targets, with every term on the path named, measured and totalled. *(BTL6)*

### 📊 CO-PO/PSO Articulation Matrix
| CO | PO1 | PO2 | PO3 | PO4 | PO5 | PO8 | PO10 | PO11 | PSO1 |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **CO1** | H | H | - | H | M | - | - | - | H |
| **CO2** | H | H | H | M | H | - | - | - | H |
| **CO3** | H | H | H | - | M | - | - | - | H |
| **CO4** | H | H | M | H | - | - | - | - | H |
| **CO5** | H | H | - | H | H | M | M | - | H |
| **CO6** | H | H | H | H | - | - | M | M | H |

*(H = High (3), M = Moderate (2), L = Low (1), - = No significant correlation)*

---

## 📚 Module-Wise Syllabus

### 📡 M1: The Network as a Measured System *(Weeks 01-02)*
* **Layering & Models:** Start with the system working; why layering exists at all; OSI vs. TCP/IP and why both survive; encapsulation specifics.
* **Metrics & Delay:** Header overhead is a number, not a nuisance; MTU as an upward constraint; the delay equation (serialisation, propagation, queueing, processing); throughput as the min-cut.
* **Observation:** The capture is the instrument; three-point captures and reading a path from three probes. Utilisation as the master variable; deriving the queueing-delay curve (finding the knee).
* **Laws & Arithmetic:** Little's Law; where M/M/1 lies to you; bandwidth-delay product; jitter, percentiles, and why the mean lies; impairment, baseline, and "the number that lies".
* **Practical Context:** What this course owns vs. CDIS and SDSR. Loss, buffers, and the trap of adding memory. Measurement methodology.
* **Scenarios & SETU:** The transfer that stopped at 1.2 MB; the dashboard that was green all night. *SETU:* topology skeleton up; baseline measured; EDGE budget v0 stated; STACK CP0 (webget over a kernel socket, flow-controlled ByteStream).

### 🖧 M2: Being the Stack *(Weeks 04-07)*
* **Sockets & App Layer:** Sockets as syscalls; `listen()` queue; the six things that break networked code; framing; HTTP/1.1 implementation; round trips as currency; DNS as diagnose level and load-balancing plane (diagnosing DNS in seven tests).
* **Concurrency:** The true cost of 10k connections; thread per connection, `select()`, `poll()`, `epoll` (and `kqueue`); level vs. edge-triggered; event loops and non-blocking necessity; backpressure; multi-core; timeouts at scale.
* **Transport (UDP/TCP):** UDP promises nothing; TCP promises and delivery machines; sequence wrapping (32 bits); the reassembler; flow control (window = capacity); reliability and resends; retransmission timer (Jacobson/Karels); teardown/`TIME_WAIT`; Nagle meets delayed ACK.
* **Congestion Control:** Slow start; AIMD; fast recovery vs. fast retransmit; Mathis relation (predict, measure, explain gap); fairness; buffer sizing; Cubic, BBR, ECN ("what signal?"); TLS 1.3, TLS-chain validation, ALPN.
* **Scenarios & SETU:** Checkpoints CP1-CP5; *The Interop Gate:* 1 MB bidirectional transfer against Linux kernel TCP over impaired link. DNS in depth. Failover that took a day; fine-until-broken service; 13 Mbit/s transfer; the upgrade that made it slower.

### 🗺️ M3: Addressing, Routing and Internetworking *(Weeks 03, 08)*
* **Addressing:** The address mistake that shaped the internet; prefix arithmetic; VLSM design; summarisation; non-ordinary addresses; IPv6 as a working scheme.
* **DHCP & ARP:** DHCP end-to-end and DHCPv4; diagnostic order for "it has no address" (injected fault 1); two planes split design; longest-prefix match; ARP boundaries.
* **Routing:** Distance-vector vs. link-state; count-to-infinity mitigations; OSPF convergence budget; route selection order; NAT problems; first-hop redundancy; BGP (not shortest-path); overlays and MTU cost.
* **Scenarios & SETU:** *SETU-LINK:* address plan (+60% growth forecast), relayed DHCP, DNS zones, OSPF (<5s convergence), dual uplink without black-holing. *STACK CP6:* NetworkInterface (ARP) and longest-prefix-match router (3 subnets). Cloud VPC NAT. Unroutable mergers; unadvertised summaries.

### 🔌 M4: Below the IP Address *(Weeks 09-10)*
* **Wired Media:** Frames and FCS guarantees; CRC over GF(2) (polynomial division); MAC learning; VLANs/trunks; catastrophic layer-2 loops; spanning tree; link aggregation hashing; media budgets; Shannon and Nyquist limits; switch inside the server.
* **Wireless (RF):** RF link budget; CA vs. CD; hidden node; SNR to data rate (MCS ladder); three bands; airtime as the core concept; roaming decisions; Wi-Fi 6/7 changes; channel planning; airtime fairness.
* **Constrained Links:** Small MTUs, duty cycles, and capacity problems disguised as coverage problems.
* **Scenarios & SETU:** *SETU-LINK:* VLANs, trunks, STP, LACP; wireless segment. *STACK CP7:* frame layer with CRC-32 (byte-identical across burst error corpus). *EDGE:* constrained links. *Fault Bank:* four invisible faults. The 09:14 building outage; lecture theatre capacity fail.

### ⚙️ M5: Running What You Built *(Week 11)*
* **Troubleshooting Methodology:** Problem statement, falsifiable hypothesis & test, elimination, evidence, one-change fix (with blast radius/reversal stated), user-viewpoint verification.
* **Observability & Security:** Cardinality, flow sampling; availability arithmetic/chain. Filtering (ACLs/stateful firewalls: order = policy); identity at the edge & zero trust; VPN MTU costs; token bucket rate limiting.
* **Automation:** Idempotency; Ansible and Python against reachable devices; 5 management approaches; AI in NetOps (the 2 things to know); Documentation (5 artefacts, 5 questions).
* **Scenarios & SETU:** *SETU-LINK:* monitored, automated, hardened. *The Diagnosis Gate:* root-cause Fault Bank faults within a time limit. *STACK CP8:* TLS termination, ALPN, rejecting expired/wrong-name certs correctly. The change that was never made.

### ⏱️ M6: Predictability *(Week 12)*
* **Real-time Traffic:** Jitter; tail-sized playout buffers; queue disciplines & bounds; DiffServ; policing vs. shaping; codec rate vs. wire rate (media bandwidth); the E-model (delay/loss to a number); delay budget distribution.
* **Advanced Routing:** Multicast and group management; PTP and unmeasurable errors.
* **Scenarios & SETU:** *SETU-EDGE:* Meet/refute requirement end-to-end (p50 ≤ 8 ms, p99 ≤ 20 ms; jitter p99-p50 ≤ 12 ms; loss ≤ 0.1% / 60s) during a 200 Mbit/s bulk transfer. *The Integration Gate:* Edge traffic crosses your fabric, router, and transport; live fault injection/diagnosis; defend latency budget against measured p99. Configured everywhere, worked nowhere QoS.

---

## 🏗️ SETU Network Studio (Project Deliverables)

One project cannot carry this syllabus honestly, so there are three layers wired together in Week 12. 

### 📂 Repository Architecture
```bash
setu/
├── link/               # 🔌 P1 (45% weight): The Infrastructure
│   ├── topology/       # containerlab / netns definitions
│   ├── ansible/        # inventory, roles, playbooks
│   ├── design/         # ADDRESS-PLAN.md, TOPOLOGY.md, POLICY.md
│   ├── verify/         # reachability matrix, convergence timer
│   └── diagnostics/    # one log per Fault Bank case
│
├── stack/              # ⚙️ P2: The Implementation
│   ├── src/            # byte_stream.c, reassembler.c, receiver.c, sender.c
│   ├── tests/          # testing harnesses for kernel-interop
│   └── measure/        # throughput vs. loss, predicted vs. observed
│
├── edge/               # 🚀 P3: Traffic With a Deadline
│   ├── topology/       # edge topology configs
│   ├── qos/            # Quality of Service configurations
│   ├── measure/        # measurement logic for time-sensitive traffic
│   └── BUDGET.md       # the latency budget, term by term
│
└── JOURNEY.md          # 📓 Weekly design decision logs
```

### 📋 Key Studio Rules & Gates

> 📓 **The JOURNEY.md Rule:** Every week, record one design decision, the alternative rejected, and the accepted cost. *Engineering is choosing under constraint; a repository showing only the choice hides the engineering.*

> 🛑 **The Standing Rule on Metrics:** No number is asserted. Every figure must be computed by code on the page. *A throughput figure in your report that you did not measure twice is not a result.*

* 🚧 **The Interop Gate (Week 6):** Pass by completing a bidirectional 1 MB transfer with an unmodified kernel TCP peer over an impaired link.
* 🩺 **The Diagnosis Gate (Week 11):** Pass by correctly root-causing Fault Bank faults within a time limit, providing a strict `hypothesis → test → evidence → fix → verify` log.
* ⏱️ **The Integration Gate (Week 12):** Pass by maintaining strict p50/p99 latency margins while edge traffic runs through your custom stack and automated infrastructure during an active fault injection.

---

## 🗓️ Studio Depth Modules & Schedule
1. **W01:** Network as measured system | **W07:** Congestion control, fairness, TLS
2. **W02:** Performance, queueing, measurement | **W08:** Routing, forwarding, NAT, IPv6
3. **W03:** Addressing, subnetting, DHCP | **W09:** Ethernet, switching, media
4. **W04:** Sockets, HTTP, DNS | **W10:** Wireless, RF, channel access
5. **W05:** Concurrency, epoll, C10K wall | **W11:** Operations, security, automation
6. **W06:** UDP, TCP mechanics, reliability | **W12:** Real-time, multicast, constrained

**Additional Modules:**
CCNA domain clinic • Command appendix • Packet capture • Subnetting drill • Timed mock exam • Simulators & topologies • Lab setup & portfolio • Study plan • Glossary • Security concepts • Network programming in Python

*(Note: Certification tracks include Network+ N10-009 timed PBQ items and Cisco IOS CCNA translations).*

---

## 📖 Reference Literature

1. 📘 **Computer Networking: A Top-Down Approach** (8th Ed.) — *James F. Kurose & Keith W. Ross* (Pearson, 2021)
2. 📙 **TCP/IP Illustrated, Volume 1: The Protocols** (2nd Ed.) — *Kevin R. Fall & W. Richard Stevens* (Addison-Wesley, 2011)
3. 📗 **Unix Network Programming, Volume 1: The Sockets Networking API** (3rd Ed.) — *W. Richard Stevens, Bill Fenner & Andrew M. Rudoff* (Addison-Wesley, 2004)
4. 📕 **Computer Networks: A Systems Approach** (6th Ed.) — *Larry L. Peterson & Bruce S. Davie* (Morgan Kaufmann, 2021)
5. 📓 **High Performance Browser Networking** — *Ilya Grigorik* (O'Reilly Media, 2013)
6. 🐧 **The Linux Programming Interface** — *Michael Kerrisk* (No Starch Press, 2010)
7. 📖 **CompTIA Network+ Study Guide: Exam N10-009** (6th Ed.) — *Todd Lammle & Jon Buhagiar* (Sybex/Wiley, 2024)
8. 🛡️ **CCNA 200-301 Official Cert Guide Library** (2nd Ed.) — *Wendell Odom* (Cisco Press, 2024)
