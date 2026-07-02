---
layout: post
title: Recent trends on computing
date: 2026-07-02 12:00:00
description: Some thoughs on the recent computing trends 
tags: 
categories: 
featured: false
---

I was invited to write a short note on recent computing trends in two different programs, [2026 StarTrack Scholars](https://www.microsoft.com/en-us/research/articles/microsoft-research-asia-startrack-scholars-2026-a-holistic-approach-to-systems-and-networking-in-the-ai-era/) and [2026 Honorary Scholars](https://www.microsoft.com/en-us/research/project/msrahonoraryscholars/), respectively. The two programs are 6 months apart. And the two versions have some noticeable difference. 

You can find the difference yourself.


## StarTrack Scholar Program 2026

Two transformative trends are shaping the future of computing.

First, the relentless pursuit of scale: the drive to build ever-larger foundation neural models that push the boundaries of artificial intelligence (AI).

Second, the rise of agentic systems: fueled by the growing capabilities of AI, the corresponding systems are moving beyond passive prediction to active engagement, empowering AI agents that can autonomously reason, act, and interact with dynamic environments through tools, APIs, and other systems.

**The Challenge of Scaling**

The first trend exposes the fundamental limits of today’s AI infrastructure. Continued scaling faces severe constraints: energy consumption, manufacturing costs, and the diminishing returns of conventional GPU-based architectures as well as network technology. To sustain progress, future AI infrastructure must go beyond raw compute density and networking performance; it must rethink system and network design from the ground up.

**The Challenge of Agentic Workloads**

The second trend shifts our understanding of AI workloads themselves. Agentic systems blend large-model reasoning with diverse, CPU-centric tool use and environment interactions. This hybrid nature creates dynamic and heterogeneous computation patterns that challenge today’s GPU-dominated infrastructure. Building efficient systems for such workloads demands a deep understanding of how intelligence manifests across both GPU- and CPU-intensive tasks.

**A Holistic Path Forward**

We envision a holistic co-design between AI workloads and the underlying infrastructure.
AI itself must evolve to embrace new architectural paradigms, e.g., from uniform to non-uniform systems, from general-purpose to AI-aware hardware, and from monolithic to modular scalability.
Conversely, infrastructure must be reimagined to serve AI as its first-class citizen, shedding unnecessary general-purpose complexity to achieve unprecedented efficiency and scalability.

At the same time, frontier AI models now demonstrate a remarkable capability to understand and reason about complex system and networking concepts. This opens up a new frontier: AI-driven systems and networking innovation, where AI not only runs on infrastructure but co-designs and optimizes it, accelerating the evolution of computing itself.

<hr>

## Hononary Scholar Program 2026

Modern computing is entering a new phase where systems and AI co-evolve.

Historically, systems innovation has enabled advancements in AI. Today, increasingly capable AI models are making this relationship bidirectional: AI can actively accelerate systems innovation itself.

We explore AI-native systems—a new paradigm that treats AI as a first-class citizen in system design, rather than an external workload. Our focus spans systems that are AI-aware, AI-assisted, and increasingly AI-driven.

Our goal is to fundamentally rethink the systems research lifecycle by:

Accelerating system design, debugging, and optimization using AI
Shortening iteration cycles for systems research and development
Enabling 10× faster exploration and validation of new system ideas
Delivering real-world impact through accelerated innovation
We take a broad view of systems research, including (but not limited to) systems, networking, and hardware.

We are particularly interested in ideas that challenge the static, GPU-centric, and manually engineered nature of today’s infrastructure, moving toward adaptive, autonomous, and co-designed systems.

Research Topics include, but are not limited to:

- Self-Driving Systems Infrastructure
(e.g., LLM-assisted fault diagnosis, autonomous configuration tuning, AI-driven capacity planning and anomaly detection)

- Agentic AI Systems and Heterogeneous Execution (CPU/GPU Co-Design)
(e.g., speculative tool execution for agent workloads, CPU/GPU co-scheduling, dynamic resource allocation for multi-step agent pipelines)

- AI-Assisted System Design, Debugging, and Verification
(e.g., LLM-powered code review for kernel/driver patches, automated root cause analysis, AI-guided formal verification of distributed protocols or mathematical proofs)

- Next-Generation Architectures for Scalable AI
(e.g., disaggregated memory/compute architectures, new accelerator designs, near-data processing for training pipelines)

- Storage, Communication, and Resource Management for Large-Scale AI Workloads
(e.g., KV cache-aware storage tiering, RDMA/NVLink topology-aware scheduling, checkpoint optimization for trillion-parameter models
