---
layout: default
title: projects
permalink: /projects/
description: my current and past research projects.
nav: true
nav_order: 4
display_categories: [current, past]
horizontal: false
---

<div class="victoria-secondary-page victoria-projects-page">
  {% include victoria_nav.liquid current="projects" %}

  <h1 class="victoria-secondary-title">Projects</h1>
  <p class="victoria-page-kicker">My current and past research projects.</p>

{% if site.enable_project_categories and page.display_categories %}
{% for category in page.display_categories %}
{% assign categorized_projects = site.projects | where: 'category', category %}
{% assign sorted_projects = categorized_projects | sort: 'importance' %}
{% if sorted_projects != empty %}

<section class="victoria-project-section" aria-labelledby="projects-{{ category | slugify }}">
<h2 id="projects-{{ category | slugify }}" class="victoria-project-category">{{ category | capitalize }}</h2>
<div class="victoria-resource-list victoria-project-list">
{% for project in sorted_projects %}
{% assign project_url = project.url | relative_url %}
{% if project.redirect %}
{% assign project_url = project.redirect %}
{% endif %}
<article class="victoria-resource-panel victoria-project-record">
<h3><a href="{{ project_url }}">{{ project.title }}</a></h3>
<div class="victoria-resource-copy victoria-project-summary">
{% if project.description and project.description != blank %}
<p>{{ project.description }}</p>
{% else %}
{{ project.excerpt | markdownify }}
{% endif %}
</div>
<p class="victoria-project-meta">
<span>{{ project.category | capitalize }}</span>
{% if project.related_publications %}<span>Related publications</span>{% endif %}
{% if project.github %}<a href="{{ project.github }}">Code repository</a>{% endif %}
<a href="{{ project_url }}">Details</a>
</p>
</article>
{% endfor %}
</div>
</section>
{% endif %}
{% endfor %}
{% else %}
{% assign sorted_projects = site.projects | sort: 'importance' %}
<div class="victoria-resource-list victoria-project-list">
{% for project in sorted_projects %}
{% assign project_url = project.url | relative_url %}
{% if project.redirect %}
{% assign project_url = project.redirect %}
{% endif %}
<article class="victoria-resource-panel victoria-project-record">
<h3><a href="{{ project_url }}">{{ project.title }}</a></h3>
<div class="victoria-resource-copy victoria-project-summary">
{% if project.description and project.description != blank %}
<p>{{ project.description }}</p>
{% else %}
{{ project.excerpt | markdownify }}
{% endif %}
</div>
<p class="victoria-project-meta">
{% if project.category %}<span>{{ project.category | capitalize }}</span>{% endif %}
{% if project.related_publications %}<span>Related publications</span>{% endif %}
{% if project.github %}<a href="{{ project.github }}">Code repository</a>{% endif %}
<a href="{{ project_url }}">Details</a>
</p>
</article>
{% endfor %}
</div>
{% endif %}

  <p class="victoria-back-link"><a href="{{ '/' | relative_url }}">&larr; Back</a></p>
</div>
