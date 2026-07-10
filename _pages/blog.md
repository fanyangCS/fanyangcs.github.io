---
layout: default
permalink: /blog/
title: blog
nav: true
nav_order: 1
pagination:
  enabled: true
  collection: posts
  permalink: /page/:num/
  per_page: 5
  sort_field: date
  sort_reverse: true
  trail:
    before: 1 # The number of links before the current page
    after: 3 # The number of links after the current page
---

<div class="victoria-secondary-page victoria-blog-page">
  <nav class="victoria-secondary-nav" aria-label="Site navigation">
    <a href="{{ '/' | relative_url }}">About</a>
    <a href="{{ '/blog/' | relative_url }}" aria-current="page">Blog</a>
    <a href="{{ '/news/' | relative_url }}">News</a>
    <a href="{{ '/publications/' | relative_url }}">Publications</a>
    <a href="{{ '/projects/' | relative_url }}">Projects</a>
  </nav>

  <h1 class="victoria-secondary-title">Blog</h1>

{% assign blog_description_size = site.blog_description | size %}
{% if blog_description_size > 0 %}

<p class="victoria-page-kicker">{{ site.blog_description }}</p>
{% endif %}

{% if page.pagination.enabled %}
{% assign postlist = paginator.posts %}
{% else %}
{% assign postlist = site.posts %}
{% endif %}

  <div class="victoria-resource-list victoria-blog-list">
    {% for post in postlist %}
      {% if post.external_source == blank %}
        {% assign read_time = post.content | number_of_words | divided_by: 180 | plus: 1 %}
      {% else %}
        {% assign read_time = post.feed_content | strip_html | number_of_words | divided_by: 180 | plus: 1 %}
      {% endif %}

      <article class="victoria-resource-panel victoria-blog-item">
        <h2>
          {% if post.redirect == blank %}
            <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
          {% elsif post.redirect contains '://' %}
            <a href="{{ post.redirect }}" target="_blank" rel="external nofollow noopener">{{ post.title }}</a>
          {% else %}
            <a href="{{ post.redirect | relative_url }}">{{ post.title }}</a>
          {% endif %}
        </h2>
        {% if post.description %}
          <p class="victoria-resource-copy">{{ post.description }}</p>
        {% endif %}
        <p class="victoria-post-meta">
          {{ post.date | date: '%B %d, %Y' }} &middot; {{ read_time }} min read{% if post.external_source %} &middot; {{ post.external_source }}{% endif %}
        </p>
      </article>
    {% endfor %}

  </div>

{% if page.pagination.enabled %}

<div class="victoria-pagination">{% include pagination.liquid %}</div>
{% endif %}

  <p class="victoria-back-link"><a href="{{ '/' | relative_url }}">&larr; Back</a></p>
</div>
