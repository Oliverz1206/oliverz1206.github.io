## Oliver Z – Personal Site

Personal website for Oliver Zhang, built on top of the Jekyll **Chirpy** theme and customized for a bilingual resume, project & publication showcases, structured notes, and blogs.

The site is deployed at:

- **Live site**: `https://oliverz1206.github.io`

---

## Main sections of the site

- **Resume**
  - Bilingual (English / 中文) resume with a custom `resume` layout.
  - Language toggle and **Download PDF** button powered by front‑matter:
    - Markdown source: `_tabs/resume.md`
    - PDFs: `/assets/files/resume_en.pdf`, `/assets/files/resume_cn.pdf`
  - Content is split using markers `<!--lang:en-->` and `<!--lang:cn-->`, which the layout parses and renders.

- **Projects**
  - Card-style project gallery using the `showcase` layout.
  - Data source: posts under `_posts/projects/` with `categories: [Projects]`.
  - Supports cover images, tags, and pinning; project ordering is controlled by `showcase_rank` (via a custom plugin).

- **Publications**
  - Similar to Projects, also using the `showcase` layout.
  - Data source: `_posts/publications/` with `categories: [Publications]`.
  - Intended for papers, articles, or major public outputs.

- **Notes**
  - Structured technical notes organized hierarchically (e.g. top category **Notes**, then sub-areas and topics).
  - Uses a specialized notes index (`lists` + `list` layouts) and a custom `hierarchical-indexes` generator.
  - Intended to act as a long-term, navigable knowledge base.

- **Blogs**
  - Time-ordered blog posts (personal reflections, updates, or longer narratives).
  - Tab source: `_tabs/blogs.md` with the `archive` layout.
  - Posts live under `_posts/blogs/` with `categories: [Blogs]` and are grouped by year.

- **Tags**
  - Tag index / cloud powered by `_tabs/tags.md` and the theme’s `tags` layout.
  - Each tag page lists associated posts across Projects, Publications, Blogs, and Notes.

- **About**
  - Static about page rendered from `_tabs/about.md`.
  - Good place for a short bio, high-level summary of interests, or contact links.

For a more detailed, file-by-file explanation see `TECH.md`.

---

## Technology stack

- **Static site generator**: Jekyll
- **Theme**: `jekyll-theme-chirpy` (`~> 7.3`, configured in `Gemfile`)
- **Language / runtime**: Ruby `3.4.8` (see `.ruby-version`)
- **Custom plugins** (in `_plugins/`):
  - `showcase-settings.rb`: integrates the Projects / Publications tabs with `jekyll-paginate-v2`.
  - `posts-lastmod-hook.rb`: injects `last_modified_at` into posts based on Git history.
  - `permalink-normalizer.rb`: normalizes slugs and `permalink` for posts using `_config.yml.slugify`.
  - `page-classifier.rb`: decides which post-tail components to show per top-level category.
  - `hierarchical-indexes.rb`: generates hierarchical indexes (e.g. for Notes) under URLs like `/notes/...`.

---

## Repository structure (high level)

This is a simplified view focused on the parts you are most likely to edit:

- **Root**
  - `README.md`: this overview.
  - `TECH.md`: detailed technical notes on structure and behavior.
  - `_config.yml`: global site configuration (title, URL, navigation behavior, plugins, permalinks, etc.).
  - `Gemfile` / `.ruby-version`: Ruby & gem versions.
  - `.nojekyll`: ensures GitHub Pages serves raw files from `_site` without its own Jekyll pass.

- **Content & navigation**
  - `_tabs/`: top-level navigation tabs such as `resume`, `projects`, `publications`, `notes`, `blogs`, `tags`, `about`.
  - `_posts/projects/`: project posts (cards in the Projects tab).
  - `_posts/publications/`: publication posts.
  - `_posts/blogs/`: blog posts.

- **Layouts, includes, plugins**
  - `_layouts/`: page/post templates such as `post.html`, `showcase.html`, `resume.html`, `list.html`, `lists.html`, `archive.html`.
  - `_includes/`: shared partials (sidebar, topbar, related posts, paginator, etc.).
  - `_plugins/`: custom Ruby plugins that extend routing, pagination, and index generation.
  - `_data/`: small YAML configuration files for things like sharing and contact links.

- **Build outputs**
  - `_site/`: compiled static site (HTML, CSS, JS). **Generated – do not edit by hand.**
  - `.jekyll-cache/`: build cache used by Jekyll. **Safe to delete; will be regenerated.**

See `TECH.md` for a more thorough walkthrough of each folder and key file.

---

## Quick start (local development)

- **1. Install prerequisites**
  - Install Ruby `3.4.8` (or a compatible 3.x) and `bundler`.
  - Make sure you can run `ruby -v` and `bundle -v` in your shell.

- **2. Install gems**

```bash
bundle install
```

- **3. Run the site locally**

```bash
bundle exec jekyll serve
```

Then open `http://localhost:4000` in your browser. Jekyll will watch for changes in Markdown, layouts, includes, and configuration.

- **4. Build for production (optional)**

```bash
JEKYLL_ENV=production bundle exec jekyll build
```

This generates the static site into `_site/`, which GitHub Pages can serve directly.

---

## How to add or edit content quickly

- **Update the resume**
  - Edit `_tabs/resume.md`.
  - English and Chinese blocks are separated by `<!--lang:en-->` and `<!--lang:cn-->`.
  - Update the PDF files under `assets/files/` and adjust `download_en` / `download_cn` in the front matter as needed.

- **Add a new project**

Create a new Markdown file under `_posts/projects/` following the date-based naming convention:

```markdown
---
title: Awesome Project
date: 2025-06-30 10:00:00 +0800
categories: [Projects]
tags: [tag1, tag2]
description: Short one-line description for the card.
image:
  path: /assets/img/projects/awesome/cover.jpg
---

Write the project details here.
```

The project will automatically appear in the Projects tab, ordered by pin status and date.

- **Add a new publication**
  - Create a new post in `_posts/publications/` with `categories: [Publications]`.
  - Use similar front matter as projects, tailored for papers or articles.

- **Write a new blog post**
  - Create a file in `_posts/blogs/` with `categories: [Blogs]`.
  - These posts will show up in the Blogs tab (archive view grouped by year).

- **Create new notes**
  - Use `categories` starting with `Notes`, then your area and topic, e.g.:

```yaml
categories: [Notes, "Computer Engineering", "CPU"]
```

  - The **hierarchical indexes** plugin and `lists` / `list` layouts will place the note under `/notes/<area>/<topic>/` and in the Notes tab tree view.

- **Tune what appears at the bottom of posts**
  - The `post_tail_format` block in `_config.yml` controls whether each top-level category shows:
    - both related posts and previous/next navigation,
    - only navigation,
    - only related posts,
    - or nothing.
  - Logic is implemented in `_plugins/page-classifier.rb` and read in `_layouts/post.html`.

---

## Deployment

This repository is configured to be served by GitHub Pages at `https://oliverz1206.github.io`.

- **GitHub Pages**
  - Push changes to the `main` branch.
  - GitHub Pages (or your CI) should run `jekyll build` and publish the contents of `_site/`.
$$
- **Customizations**
  - Global site metadata, analytics, and permalink rules: `_config.yml`.
  - Navigation structure and tab ordering: `_tabs/*.md` (see the `order` field).
  - Layout and partial behavior: `_layouts/*.html` and `_includes/*.html`.
  - Advanced behavior (pagination, slug rules, hierarchical indexes): `_plugins/*.rb`.

For deeper technical notes and “where to change what”, refer to `TECH.md`.
