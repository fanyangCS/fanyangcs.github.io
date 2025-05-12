---
layout: page
title: Vector store
description: 
img: assets/img/9.jpg
importance: 1
category: current
related_publications: true
---

Vector store is an important storage system in the AI era. I believe it not only serves as an cache used to retrieve computation results from neural networks, but also becomes (or will become) a fundamental component at the core of neural models. 
For example, we realized that attention, a fundamental mechanism in the Transform-like neural architecture, can be viewed as vector index traversal {% cite retrievalattention2024 %}. 
This makes the computation of sparse attention much more efficient. In the case of LLMs with a long context window, the benefit can be of one or multiple orders of magnitude.

Here are some of our thoughts on vector store.
- Integrating vector indices with relational databases using relaxed monotonicity. {% cite DBLP:conf/osdi/ZhangXCSXCCH00Y23 %}.
- Updating a vector index incrementally. {% cite DBLP:conf/sosp/XuLLXCZLYYYCY23 %}.
- Vector indices can be dense or sparse. Instead of represented with separated solutions, they can be unified with one generic design. {% cite 10.1145/3589335.3648338 %}.
- Attention can be transformed as vector retrieval, thus making sparse attention significantly more efficient. {% cite retrievalattention2024 %}, {% chen2025retroinfervectorstorageapproachscalable %}
