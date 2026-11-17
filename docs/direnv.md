# What is direnv?
If we want to use a CLI operation but required some of variables inside .env, we can use this program. Direnv allow to use .env inside the project scope, which is safe to use.

# How to install?
1. `sudo apt install direnv`
2. Hook to shell to allow it automatically active if we switched folder.
`eval "$(direnv hook zsh)"` (zsh/bash, depends on your terminal)
3. Create [.envrc](../.envrc) to set it up:
```
export VIRTUAL_ENV=./.venv # Used when direnv wants to write .venv not on the direnv default venv location, but we want it on root project with the folder named .venv
layout python # Create a venv if not exists and automatically activate it in the terminal.
dotenv .env # Explicitly tell direnv our .env file.
```
4. `direnv allow` to run it.
