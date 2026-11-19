# What is airflowing?
Airflowing is my personal Airflow project. Later I'll turn it into `airfloward`, a cookiecutter template based on this repo.

# Why this repo?
Most of my work experience is on managed data platforms such as Databricks and Snowflake, and that work lives in private company repos. I use this repo to learn and practice, in the open:

- Running an open-source orchestrator (Airflow) end to end
- Structuring both the code and the data with a clear architecture
- Ensuring clean code with tools like Ruff and SQLFluff
- Write Pythonic and SQL code that I learned from
- Testing at different levels: unit, integration and end-to-end
- Setting up CI/CD

It's a work in progress, and it also serves as my portfolio.

# Prerequisite
1. [Docker](https://docs.docker.com/get-docker/desktop/)
2. [uv](https://docs.astral.sh/uv/getting-started/installation/)

# Setup
1. `uv sync`
2. `uv run pre-commit install`
3. `cp .env.example .env` and fill in the values (see [docs/init.md](docs/init.md) for how to generate the keys)
4. `docker compose up -d`
5. Open http://localhost:8080 and log in with `_AIRFLOW_WWW_USER_USERNAME` / `_AIRFLOW_WWW_USER_PASSWORD` from `.env`

# Status
- ✅ Airflow 3 (CeleryExecutor) with Postgres, Redis and ClickHouse on Docker Compose
- ✅ Linting and pre-commit (Ruff with Airflow rules, SQLFluff)
- 🚧 dbt project on ClickHouse
- ⏳ Unit, integration and end-to-end tests
- ⏳ CI/CD
