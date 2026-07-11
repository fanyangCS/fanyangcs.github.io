---
layout: default
permalink: /publications/
title: publications
description:
nav: true
nav_order: 3
---

<div class="victoria-secondary-page victoria-publications-page">
  <nav class="victoria-secondary-nav" aria-label="Site navigation">
    <a href="{{ '/' | relative_url }}">About</a>
    <a href="{{ '/blog/' | relative_url }}">Blog</a>
    <a href="{{ '/news/' | relative_url }}">News</a>
    <a href="{{ '/publications/' | relative_url }}" aria-current="page">Publications</a>
    <a href="{{ '/projects/' | relative_url }}">Projects</a>
  </nav>

  <h1 class="victoria-secondary-title">Publications</h1>

  <p class="victoria-page-kicker">Please find the complete list <a href="https://scholar.google.com/citations?user=aoVS9EkAAAAJ">on Google Scholar</a>.</p>

<!-- _pages/publications.md -->

<!-- Bibsearch Feature -->

{% include bib_search.liquid %}

  <div class="publications victoria-publications-list">

{% bibliography %}

  </div>

  <p class="victoria-back-link"><a href="{{ '/' | relative_url }}">&larr; Back</a></p>
</div>
