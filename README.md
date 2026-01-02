
## Problem
Information about after-school programs is scattered across flyers, websites, and social media. It’s difficult for parents/students to discover, evaluate, and join the right activities.

## Target Users
- **Students (grades 1–12):** tutoring, clubs, sports
- **Parents/Guardians:** safe, age-appropriate activities (local or online)
- **Organizers/Coaches/Teachers:** create and manage events

## Core Features (MVP)
- User accounts + profiles (students, parents, organizers)
- Create and manage events (sports/tutoring/language)
- Browse events (list + detail)
- Join events
- Save/favorite events
- Organizer dashboard (see your events + participants)

## Stretch Features (time-permitting)
- Ratings/reviews for events
- Search and filters (category, city, online/local)



---

# Tech Stack
- **Ruby:** 3.3.6 (latest stable)
- **Rails:** 7.2.3 (latest stable)
- **Database:** Postgres
- **CSS:** Tailwind (tailwindcss-rails)
- **Testing:** RSpec
- **Auth:** Devise
- **Roles:** Rolify (supports multi-role users like parent + organizer)
- **Authorization:** Pundit
- **Linting:** RuboCop
- **CI:** GitHub Actions (RSpec + RuboCop)

---

# Data Model (Option A)
We are intentionally keeping this small.

1. **User**
2. **Event**
3. **Enrollment** (user joins event)
4. **Favorite** (user saves event)
5. **Review** (ratings/comments)

## Role Notes
Users can have multiple roles (e.g., **parent + organizer**). Roles are managed through Rolify. Permissions are enforced through Pundit policies.

---

# Repo Workflow (IMPORTANT)
We use two protected branches:
- `main` = stable, demo-ready
- `dev` = integration branch

### Branching
Create feature branches off `dev`:
- `name/description/ticket`
- `name/bugfix/ticket`

### Pull Requests
- **One ticket per PR**
- Keep PRs small and testable
- Include testing steps in PR description
- CI must pass (RSpec + RuboCop)

### No direct pushes
Do not push directly to `dev` or `main`. Always open a PR.

---

# Getting Started

## 1) Prerequisites
- Ruby 3.3.6 installed (rbenv recommended)
- Postgres installed and running
- Bundler installed

## 2) Clone the repo

```bash
git clone <REPO_URL>
cd <REPO_NAME>
```

## 3) Install dependencies

```bash
bundle install
```

## 4) Setup the database

```bash
bin/rails db:create
bin/rails db:migrate
```

## 5) Seed data (for development/demo)

```bash
bin/rails db:seed
```

## 6) Run the app

```bash
bin/dev
```
or
```bash
bin/rails s
./bin/rails tailwindcss:install # in another terminal
```

# Development Commands

## Run tests (RSpec)

```bash
bundle exec rspec
```

## Run lint (RuboCop)

```bash
bundle exec rubocop
```

## Auto-fix lint where possible

```bash
bundle exec rubocop -A
```

## Reset DB (if you get stuck)

⚠️ This deletes local data.

```bash
bin/rails db:drop db:create db:migrate db:seed
```

---

# Authentication / Authorization Notes

* **Devise** handles login/signup
* **Rolify** stores roles (multi-role supported)
* **Pundit** enforces permissions in policies (source of truth)

Rules we enforce:

* Only **organizers** can create/edit events
* Users must be logged in to **join** or **favorite**
* Only enrolled users can leave reviews (if reviews are implemented)

---

We work in 2-week sprints. Each ticket should include:

* Feature implementation
* Validation + error handling
* Loading + empty states (where relevant)
* Authorization checks (where relevant)
* Tests when practical

---

# How to Contribute

1. Pull latest `dev`:

```bash
git checkout dev
git pull
```

2. Create a branch:

```bash
git checkout -b new_branch_name
```

3. Commit often:

```bash
git add .
git commit -m "Implement <ticket>"
```

4. Push and open PR to `dev`:

```bash
git push
```

5. In the PR description include:

* What changed
* How to test
* Ticket link

---

# Troubleshooting

## CI fails on lint

Run locally:

```bash
bundle exec rubocop -A
bundle exec rubocop
```


## “It works on my machine”

Ensure your branch is up to date:

```bash
git checkout dev
git pull
git checkout <your-branch>
git merge dev
```

---

# Contact / Communication

* Use Slack for blockers and coordination
* If you edit shared models or migrations, post a heads-up in Slack first
* We aim to check Slack daily and respond back messages (emoji is fine)

