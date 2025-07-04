---
layout: page
title: AI compiler
description: 
img: assets/img/1.jpg
importance: 1
category: current
related_publications: true
---

AI compiler translates neural network into low level device code, e.g., CUDA. It plays a critical role to ensure the efficient scaling of neural network. 

In the past, we developed a series of compiler techniques to advocate the tile-based abstraction on canonical deep learning compilation on SIMT based AI hardware (e.g., GPU). 
This includes Rammer {% cite DBLP:conf/osdi/MaXYXMCHYZZ20 %}, Roller {% cite DBLP:conf/osdi/ZhuWDKLZXMXC0YZ22 %}, Welder {% cite DBLP:conf/osdi/00010XMXMG0Z23 %}, and Cocktailer {% cite DBLP:conf/osdi/ZhangMXSM0Z0Y23 %}.
These techniques were covered in an [MSR Research blog](https://www.microsoft.com/en-us/research/blog/building-a-heavy-metal-quartet-of-ai-compilers/). And the tile abstraction is now well recognized in the systems community. 

In addition, we correctly envisioned the importance of taking model sparsity into account in compiler techniques, and developed the first sparsity-aware compilers, SparTA {% cite DBLP:conf/osdi/ZhengLZMY0WYZ22 %}, PIT {% cite DBLP:conf/sosp/ZhengJZHM0YZQYZ23 %}, and nmSPARSE {% cite MLSYS2023_a10deb4d %}, and compilers for low-bit neural models, e.g., Ladder {% cite ladder24 %}. They are all successfully unified under the tile abstraction.

Our next focus is compiler techniques for AI hardware with new architecture. For example, the more recent GPUs comes with heterogeneous hardware units, including tensor core, CUDA core, and Tensor Memory Accelerator (TMA). This introduces system opportunities that design new mechanisms that enables sophisticated compute schedule, e.g., pipelining, for extreme performance {% cite pipethreader25 %}. Another new hardware trend is the distributed memory architecture (i.e., non SIMT) {% cite waferllm25 %}. Meanwhile, the programming interface of neural network is an important topic related to compiler techniques. We will continue to investigate in new programming models like [tile-lang](https://tilelang.com/) and FractalTensor {% cite FractalTensorSosp24 %}.

Interestingly, we observe that compiler techniques are also useful in distributed deep learning training and automated machine learning. Based on the observation, we developed nnScaler {% cite nnscaler24 %}, a flexible and efficient distributed training framework, and [NNI](https://github.com/microsoft/nni), a popular AutoML toolkit {% cite DBLP:conf/osdi/ZhangHYZLYZ20 %}.
