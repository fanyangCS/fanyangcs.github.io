---
layout: default
title: news
browser_title: News
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

<div class="victoria-resource-list victoria-news-list">
{% for item in news %}
<article class="victoria-resource-panel victoria-news-item">
<h2>
{% if item.inline %}
<span>{{ item.title }}</span>
{% else %}
<a class="news-title" href="{{ item.url | relative_url }}">{{ item.title }}</a>
{% endif %}
</h2>
<p class="victoria-news-meta">
<time datetime="{{ item.date | date: '%Y-%m-%d' }}">{{ item.date | date: '%B %d, %Y' }}</time>
</p>
</article>
{% endfor %}
</div>
{% else %}
<p>No news so far...</p>
{% endif %}

  <p class="victoria-back-link"><a href="{{ '/' | relative_url }}">&larr; Back</a></p>
</div>
