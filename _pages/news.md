---
layout: default
title: news
permalink: /news/
description:
nav: true
nav_order: 2
---

<div class="victoria-secondary-page victoria-news-page">
  {% include victoria_nav.liquid current="news" %}

  <h1 class="victoria-secondary-title">News</h1>

{% if site.news != blank %}
{% assign news = site.news | reverse %}

<div class="victoria-resource-list">
{% for item in news %}
<article class="victoria-resource-panel victoria-news-item">
<h2>
<time datetime="{{ item.date | date: '%Y-%m-%d' }}">{{ item.date | date: '%b %d, %Y' }}</time>
</h2>
<div class="victoria-resource-copy">
{% if item.inline %}
{{ item.content | remove: '<p>' | remove: '</p>' | emojify }}
{% else %}
<a class="news-title" href="{{ item.url | relative_url }}">{{ item.title }}</a>
{% endif %}
</div>
</article>
{% endfor %}
</div>
{% else %}
<p>No news so far...</p>
{% endif %}

  <p class="victoria-back-link"><a href="{{ '/' | relative_url }}">&larr; Back</a></p>
</div>
