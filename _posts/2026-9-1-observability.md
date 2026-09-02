---
layout: post
title: Observability in the AI era - Turning execution into useful experience
date: 2026-09-01 12:00:00
description: Growing system intelligence through observability.
tags:
categories:
featured: false
---

We have all seen some version of this result.

An optimization looks great in a microbenchmark. The kernel is faster. Memory allocation drops. One stage of the pipeline finishes sooner. Then we run the whole application, and nothing improves. Sometimes it gets worse.

The frustrating part is not only that the optimization failed. It is that the available metrics cannot tell us why. Did the new kernel disrupt communication overlap? Did lower memory pressure introduce synchronization somewhere else? Did the compiler choose a different path? We have many numbers, but no coherent story.

I increasingly think this familiar systems problem points to a larger question for AI.

AI is quickly absorbing the knowledge we have already written down about software and hardware. It can use that knowledge to generate kernels, modify runtimes, propose compiler transformations, and search configuration spaces. But [system intelligence](https://www.sigops.org/2025/the-next-horizon-of-system-intelligence/) can hardly grow from existing knowledge alone. It also needs new experience: what actually happens when an idea meets a workload, a software stack, and a machine.

Interaction creates that experience. **Observability makes the experience legible.**

## Why Does This Matter Now?

As generation becomes cheaper, trying another implementation is becoming the easy part. And understanding the result is becoming the bottleneck. This is true both for human and agent.

Execution alone does not teach much. Without observability, this is blind execution: the agent can act, but it cannot reliably learn from what happened. An agent must connect an action to its consequences, separate correlation from cause, and gather evidence strong enough to guide the next decision. Otherwise, a thousand experiments produce a thousand benchmark rows, not better system judgment.

This makes observability central in the AI era. It is still useful for debugging failures. But for an agent, or for a human working with one, it also becomes the feedback interface to the real system. This creates an experience-and-feedback loop, where observability is the key to ensure the experience accurate, interpretable, and useful for learning. Without observability, the feedback would be incomplete, delayed, or distorted, and the agent may learn the wrong lesson, or nothing at all.

## Which Old Problems Get Harder, and Which Get Easier?

The old measurement problem gets harder near the limits of the machine. AI workloads already push compute, memory bandwidth, interconnects, pipelines, and asynchronous execution. Conventional instrumentation becomes less effective as it can perturb the highly optimized behavior agent is trying to understand. A trace can alter timing. A counter can consume bandwidth. Added synchronization can erase the behavior agent wanted to study.

At the same time, causality is spread across more layers. A slowdown may begin in the model, framework scheduler, compiler, kernel library, cache, collective, or cluster. Each layer has its own identifiers, clocks, and abstractions. Most dashboards show a symptom from one layer, not the path that produced it.

But one part may get easier: analysis. AI can inspect more code and telemetry than earlier tools and follow a longer chain from source intent to framework behavior, compiler IR, PTX or assembly, hardware counters, and distributed traces. Cross-layer investigation that once required several specialists could become more routine.

There is one important condition: the observations must be trustworthy, and the reasoning must remain checkable. A fluent explanation built on perturbed or misaligned data is still the wrong explanation.

## What Is Genuinely New?

The hardware landscape is changing fast. New accelerators, scale-up fabrics, SmartNICs, and offload components couple computation, memory movement, topology, congestion, power, and thermals. Important state may be aggregated, undocumented, proprietary, or visible only through vendor-specific tools.

The software stack is changing rapidly too. A model now passes through graph capture, compilation, scheduling, kernel libraries, communication, serving, and orchestration. These modules can evolve independently, which is good for innovation but bad for observability. Following one request or training step may require evidence across machines, timescales, and semantic levels.

AI-generated optimization adds another twist. It can produce more kernel variants, schedules, compiler rewrites, and configurations than humans or AI can reliably inspect one by one. That is useful only if verification grows with generation. Otherwise, faster optimization simply creates validation debt.

So the new problem is not just collecting more telemetry. It is preserving attribution and reproducibility while both the system and the proposed changes become more dynamic.

## What Can AI Uniquely Do Here?

The obvious answer is to put an LLM on top of a dashboard. I do not think that goes far enough.

A more interesting direction is **reasoning-directed observability**. The idea is simple: the AI should not only read whatever telemetry happens to exist. It should form competing hypotheses, ask what evidence would distinguish them, and choose the next observation or experiment.

Return to our failed optimization. Suppose the agent suspects either cache pressure or disrupted communication overlap. Instead of requesting a full trace, it might _synthesize_ and compare two controlled variants, inspect one targeted event pair, or hold a fusion boundary constant while changing the memory layout. The variants are no longer just candidate optimizations. They are experiments designed to reveal hidden behavior. Doing this manually is slow and demands scarce systems expertise. AI is making it practical to conduct such experiments at much greater breadth and speed.

This also makes measurement cost part of the reasoning. The best observation is not the largest one. It is the least intrusive observation that can decide between plausible explanations. When hardware state is unavailable, simulation or a digital twin may help test whether a mechanism is consistent with the outcome. It does not need to reproduce the machine perfectly, as long as the conclusion is checked against real execution.

The loop becomes:

**observe → hypothesize → experiment → redesign → validate → learn**

[Argus](https://fanyangcs.github.io/news/argus/) is one exploratory research direction for studying a system reasoning agent or platform organized around this loop, not a claim that the loop is already solved.

## Back to the Result That Made No Sense

There is plenty of hard work left: low-perturbation measurement, cross-layer alignment, causal experiment design, uncertainty, and reproducible validation. Human judgment still matters when evidence is incomplete or a change affects safety, cost, and operability.

Still, the goal is clear. We do not need another dashboard with more charts. We need an environment in which AI can ask a precise question of a running system, gather decisive evidence, and explain what should happen next.

Then the optimization that looks good alone but fails end to end is no longer just a frustrating anomaly. It becomes useful experience. Existing knowledge proposes the change. Interaction tests it. Observability tells us why it worked or failed. And that grounded lesson returns to the next round of reasoning.

That is how system intelligence grows: not by avoiding failure, but by making every execution teach us something.
