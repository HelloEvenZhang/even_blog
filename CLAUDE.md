# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Development
bin/dev                    # Start Rails server + TailwindCSS watcher (via Foreman)
rails console              # Rails console

# Database
rails db:create db:migrate # Setup database
rails db:seed              # Load seed data

# Tests
rails test                 # Run all tests
rails test test/models/post_test.rb  # Run a single test file

# Docker (alternative)
docker-compose up --build  # Start PostgreSQL + Rails via Docker
```

## Architecture

**Rails 7.1 blog** with PostgreSQL, Hotwire (Turbo + Stimulus), TailwindCSS, and ActionText (Trix editor).

### Models

- **Post** — core blog article; rich text `content` via ActionText, one `background_image` via Active Storage, many-to-many with `Tag`, pg_search full-text search across title/description/tags (with Chinese dictionary support)
- **Comment** — belongs to Post; name remembered via cookie; submitted and rendered via Turbo Streams (real-time broadcast through Action Cable + Redis)
- **Tag** — joins to posts via `posts_tags` table

### Controllers / Routing

Two namespaces:
- **Public** (`/`): `HomeController` (root, about), `PostsController` (index with pagination, show, search), `CommentsController` (create only)
- **Admin** (`/admin`): full CRUD for `Admin::PostsController`, `Admin::TagsController`, `Admin::CommentsController`, plus `Admin::DashboardController`

### Key Patterns

- Pagination: `will_paginate`, 4 posts per page
- Search: `pg_search` with `multisearch` disabled; search scoped to `title`, `description`, and associated tag names
- Real-time comments: `CommentsController#create` broadcasts via `Turbo::StreamsChannel`
- Environment config: secrets in `.env` (not committed); `POSTGRES_URL` and `SECRET_KEY_BASE` are required env vars (see `.env.example`)

### Deployment

Capistrano deploys branch `release` to production server via Puma + Nginx. TailwindCSS is compiled (`tailwindcss:build`) before standard asset precompilation. Linked files include `database.yml` and `master.key`.
