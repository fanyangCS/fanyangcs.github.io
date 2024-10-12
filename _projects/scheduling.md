---
layout: page
title: Scheduler for AI workload
description: 
img: assets/img/3.jpg
importance: 2
category: past
related_publications: true
---

AI workload differs significantly from conventional cloud workload (e.g., big data OLAP or OLTP workload). 
In early 2017, I began to look into this problem and tried to understand the implication.
With my colleagues, we investigated a massive amount of AI workloads in Philly, Microsoft's early GPU cluster management system designed for deep learning training. 
We shared our findings in {% cite DBLP:conf/usenix/JeonVPQXY19 %}. 
We explained our thoughts on the scheduling primitives for training jobs {% cite DBLP:conf/osdi/XiaoBRSKHPPZZYZ18 %}, 
and emphasized on the importance of topology aware scheduling {% cite DBLP:conf/osdi/ZhaoHYZYZYLWXW20 %} in the AI era. 
Meanwhile, we also discovered several interesting opportunities in the coexistence of gaming and training workloads {% cite DBLP:conf/usenix/0149CH000SYG22 %}, 
codesign of caching and scheduling {% cite DBLP:conf/eurosys/ZhaoHYZ0YZL0QZZ23 %}, and elastic training {% cite DBLP:conf/asplos/GuZZXHCYHJL23 %}.

Given the strategic importance of GPU cluster management, I led an engineering group to develop [OpenPAI](https://github.com/microsoft/pai), 
a Kubernetes based open-source cluster management platform for deep learning training and inferencing. 
OpenPAI is one of the earliest k8s systems capable of managing GPU clusters. It integrated several techniques mentioned above. Its key components like [framework controller](https://github.com/Microsoft/frameworkcontroller) have been adopted by Azure AI products.
As far as I know, several external organizations also develop their training infrastructure based on OpenPAI.

