---
layout: post
title: Three levels of agent maturity
date: 2026-08-15 12:00:00
description: The goal is not given. It is discovered.
tags:
categories:
featured: false
---


Agent research usually asks how to make systems work harder toward a preset objective. People care about coding, tool use, benchmarks, planning, and task completion. They worry about goal drift: will the agent stay on task?

This line of thought assumes the hardest part has already been solved: the human knows what the task really is.

In reality, however, people often omit constraints, confuse means with ends, and discover priorities only after seeing consequences. An agent can execute the stated goal flawlessly and still fail the person who gave it. Preventing goal drift is therefore not enough. Goal fossilization, the rigid preservation of an objective after evidence has shown it to be incomplete or wrong, is also a failure.

**The goal is not given. It is discovered.**

This suggests three levels of agent maturity, illuminated by three Chinese ideas. Each level expands the agent's role.

## 1. 实事求是: Grounded in Reality

**实事求是** means seeking truth from facts. For agents, reality should correct not only beliefs about the world, but also beliefs about the goal.

Suppose a product manager asks an agent to “reduce customer-support response time.” A narrow agent optimizes the metric: shorter replies, automated closures, fewer escalations. Yet the evidence may show that customers care less about fast response than about getting the problem resolved. Reality has exposed a gap between the stated target and the underlying purpose.

At this level, an agent treats instructions as hypotheses about intent, not sacred specifications. It inspects relevant evidence, identifies contradictions, and makes uncertainty visible. It asks: What problem does this objective appear to serve? What facts would show that pursuing it literally is counterproductive?

Grounding is more than factual accuracy. It is willingness to let the world revise the assignment.

## 2. 知行合一: Unity of Knowing and Doing

**知行合一** is often translated as the unity of knowing and doing. Its relevance to agents goes beyond “make a plan, then execute it.” Action is itself a way of knowing. We learn what the goal means by trying to realize it, observing what happens, and refining our understanding.

Imagine asking a coding agent to speed up an application. Before touching the system, “faster” may sound precise. After profiling, deploying a change, and watching real usage, the intent becomes clearer: perhaps average latency was never the problem; rare freezes during checkout were. The action did not merely implement the goal. It revealed the goal.

A mature agent therefore works in a loop: form an interpretation, take a bounded action, gather feedback, and update both its method and its operational objective. It will also seek confirmation when the stakes are high.

Knowing and doing are unified when execution becomes disciplined inquiry into what should be done.

## 3. 中庸之道: Wisdom of Right Measure

Unlike a common misreading, **中庸之道** is not mediocrity or always choosing the midpoint. It is the wisdom to find the fitting response in a particular situation: the right aim, degree, timing, and balance.

Human intent is rarely singular. A person asking for the “earliest possible meeting” may also care about sleep, fairness across time zones, preparation quality, and not appearing inconsiderate. These purposes may be unstated, shifting, and in tension. A superficial reading of the request can hardly resolve the tension.

This is why mature agency requires **taste**: the capacity to know when to advance, retreat, ask, stop, or pivot. The agent should distinguish firm constraints from negotiable preferences, notice who bears the costs, and choose the right act at the right time. 

A mature agent is therefore neither obedient in the narrow sense nor autonomous in the reckless sense. It evolves the operational goal while remaining accountable to the human purposes that justify it.

## A Different Research Target

This reframes the research agenda. Can an agent infer when a target is only a proxy? Can it act properly to test its interpretation, expose conflicts among human purposes, and explain why it recommends changing course? Evaluation should measure not only task completion, but also whether the agent recognizes a misspecified objective and helps the human determine what is actually worth completing.

The next generation of agents should not merely resist goal drift. They should resist devotion to the wrong goal and approach the true intent in a delicate, balanced way.
