# What is lint?
Lint is a tools to checks your codes regarding the style, unused variables/import. Code formatter is an extension of linter to reformat it automatically. In this repo we're going to use 2 language, Python and SQL. Each languange has a different tools.

For python we're going to use Ruff. Ruff is a linter and code formatter. There are some spesific rules for Airflow 3 that we're going to implement in this repo.

For SQL, we use SQLFluff. SQLFluff also has a code formatter with different dialect for each [platforms](https://docs.sqlfluff.com/en/stable/perma/dialects.html).

Thankfully, all the configs can be used in pyproject.toml, so we can unify all the settings in one config file.

# Why use lint and code formatter?
Using lint can help us to use the same language style, therefore ensuring consistency of the codes.

# How we will use the lint and code formatter?
We're going to use it in during development and CI. In development, the vscode extensions will format the codes when we save it (Check [settings.json](../.vscode/settings.json)) and pre-commit. Pre-commit will run ruff and sqlfluff format and lint automatically when we use `git commit` before it actually commited to git.

# Ruff Configs and why?
Ruff already turns on ~400 rules by default (unused imports, common bugs, old syntax, simplifications, etc.). We keep those and only **add** a few on top with `extend-select`. Using `select` instead would **replace** the defaults.

| Config | What it does | Why |
|---|---|---|
| `line-length = 120` | Max line length | Same limit as SQLFluff, so Python and SQL look alike |
| `extend-exclude` | Skips notebooks and `fixtures/` | `extend-` keeps Ruff's built-in skips (`.git`, `.venv`, ...). Plain `exclude` would remove them |
| `format`: single quotes, spaces | Formatter style | One style for everyone |
| `AIR` | Airflow rules | Best practices (e.g. no `Variable.get` at the top of a DAG file) and Airflow 3 checks (removed or moved APIs). Some are preview-only and stay off |
| `TID251` + `banned-api` | Bans `import airflow` | Keeps `pipelines/` free of Airflow, so the business logic can move elsewhere later (e.g. Databricks) |
| `per-file-ignores` | Allows Airflow imports in `dags/` and `tests/` | Those are the only places that should touch Airflow |
| `S608` | Flags SQL built with f-strings | Prevents SQL injection. Use parameters (`args=`) instead |

Useful commands:
- `ruff check --show-settings` shows the final config (defaults + ours).
- `ruff rule <CODE>` explains a rule.

# SQLFluff Configs and why?
| Config | What it does | Why |
|---|---|---|
| `dialect = "postgres"` | SQL flavour to parse | Required, there is no default |
| `templater = "jinja"` | Reads `{{ ... }}` blocks | dbt models use Jinja. SQLFluff fakes `ref()`, `source()` and `config()`, so dbt itself is not needed |
| `max_line_length = 120` | Max line length | Same as Ruff. The default is 80 |
| `rules = "all"` | Turns on all ~80 rules | Strictest option. `"core"` is a quieter alternative |
| `capitalisation_policy = "upper"` | Keywords in UPPER case (`SELECT`, `FROM`) | One style. Without it, SQLFluff copies the style of the first keyword in each file |

Things to know:
- **No semicolon needed at the end.** dbt wraps every model in `create table ... as ( ... )`, and a trailing `;` breaks that.
- **Other SQL flavours** (e.g. Spark): put a `.sqlfluff` file in that folder with `dialect = sparksql`. It overrides `pyproject.toml` for that folder only.
- **SQL inside Python strings is not checked.** SQLFluff only reads `.sql` files, so keep queries in `.sql` files.
- **Custom dbt macros** will fail with the `jinja` templater. When that happens, look at `load_macros_from_path` or the `dbt` templater.
- `sqlfluff rules` lists every rule and its group.

# Pre-Commit Configs
1. `uv add --dev pre-commit`
2. `pre-commit sample-config` and nano it.
3. Add [ruff](https://docs.astral.sh/ruff/integrations/#gitlab-cicd) into the pre-commit file.
4. Add [sqlfluff](https://docs.sqlfluff.com/en/stable/usage/pre-commit.html) also in the pre-commit file. I switch the order fix and lint by using fix first, then lint from the template. The reason is to eliminate lint error from the code that can be fixed automatically.
 5. Run `pre-commit install`
6. Run `pre-commit run --all-files` for the first time.
