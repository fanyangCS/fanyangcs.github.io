---
layout: page
title: AI compiler
description: 
img: assets/img/1.jpg
importance: 1
category: work
related_publications: true
---

AI compiler translates a neural network into low level device code, e.g., CUDA. It plays a critical role to ensure the efficient scaling of neural networks. 

In the past, we have developed a series of compiler techniques to explain our view on cononical deep learning compilation. 
This includes Rammer {% cite DBLP:conf/osdi/MaXYXMCHYZZ20 %}, Roller {% cite DBLP:conf/osdi/ZhuWDKLZXMXC0YZ22 %}, Welder {% cite DBLP:conf/osdi/00010XMXMG0Z23 %}, and Cocktailer {% cite DBLP:conf/osdi/ZhangMXSM0Z0Y23 %} (covered in an [MSR Research blog](https://www.microsoft.com/en-us/research/blog/building-a-heavy-metal-quartet-of-ai-compilers/)). 
We also correctly envisioned the importance of model sparsity, and have developed the first sparsity-aware compilers, SparTA {% cite DBLP:conf/osdi/ZhengLZMY0WYZ22 %} and PIT {% cite DBLP:conf/sosp/ZhengJZHM0YZQYZ23 %}. 
We believe the next focus of AI compiler will be techniques designed for AI hardware with distributed memory architecture. 
