---
title: poetry
nav_order: 4
---

# poetry
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

poetry is a dependency and packaging (for publishing) manager for Python projects. In other words, it resolves library dependencies and it can be used for building and publishing your project.

Why `poetry` instead of the _official-ish_ `pipenv`? As of early 2020, it seems poetry has won people's mind and shell. For instance, [Jacob Kaplan-Moss](https://jacobian.org/2019/nov/11/python-environment-2020/) ([HN](https://news.ycombinator.com/item?id=21510262)), [Hugo Hjerten](https://blog.jayway.com/2019/12/28/pyenv-poetry-saviours-in-the-python-chaos/), [johnfraney](https://johnfraney.ca/posts/2019/11/19/pipenv-poetry-benchmarks-ergonomics-2/).


## Install poetry via pipx

<div class="warning-box">Before installing poetry, you must install and configure pipx first. <a href="/python-on-macos/pipx.html">Read the setup instructions here</a>.</div>

Install `poetry` using `pipx`:

```sh
pipx install poetry
  installed package poetry 1.0.5, Python 3.8.2
  These apps are now globally available
    - poetry
  done! ✨ 🌟 ✨

which poetry
  /Users/<USER_NAME>/.local/bin/poetry
```

## Prevent poetry from creating virtualenvs

```sh
poetry config --list
  cache-dir = "/Users/<USER_NAME>/Library/Caches/pypoetry"
  virtualenvs.create = true
  virtualenvs.in-project = false
  virtualenvs.path = "{cache-dir}/virtualenvs"  # /Users/<USER_NAME>/Library/Caches/pypoetry/virtualenvs

ls ~/Library/ApplicationSupport/pypoetry
  config.toml

poetry config virtualenvs.create false

poetry config --list
  cache-dir = "/Users/<USER_NAME>/Library/Caches/pypoetry"
  virtualenvs.create = false
  virtualenvs.in-project = false
  virtualenvs.path = "{cache-dir}/virtualenvs"  # /Users/<USER_NAME>/Library/Caches/pypoetry/virtualenvs

cat ~/Library/ApplicationSupport/pypoetry/config.toml
  [virtualenvs]
  create = false
```

Please note that we must set `poetry config virtualenvs.create false`. Our `virtualenv` needs are already taken care by `pyenv-virtualenv`, we do not need `poetry` creating its own virtualenvs.


## Upgrade poetry via pipx

```sh
pipx upgrade poetry
```

## Uninstall poetry via pipx

```sh
pipx uninstall poetry
```

For more information, read [the docs](https://python-poetry.org/docs/#installing-with-pipx).

## Usage examples

### poetry init

```sh
poetry --version
  Poetry version 1.0.5

mkdir test-proj && cd test-proj

poetry init
  This command will guide you through creating your pyproject.toml config.

  Package name [test-proj]:
  Version [0.1.0]:
  Description []:
  Author [Lucas Amaro <lucasrla@users.noreply.github.com>, n to skip]:
  License []:
  Compatible Python versions [^3.8]:

  Would you like to define your main dependencies interactively? (yes/no) [yes]
  You can specify a package in the following forms:
    - A single name (requests)
    - A name and a constraint (requests ^2.23.0)
    - A git url (git+https://github.com/python-poetry/poetry.git)
    - A git url with a revision (git+https://github.com/python-poetry/poetry.git#develop)
    - A file path (../my-package/my-package.whl)
    - A directory (../my-package/)
    - An url (https://example.com/packages/my-package-0.1.0.tar.gz)

  Search for package to add (or leave blank to continue):

  Would you like to define your development dependencies interactively? (yes/no) [yes]
  Search for package to add (or leave blank to continue):

  Generated file

  [tool.poetry]
  name = "test-proj"
  version = "0.1.0"
  description = ""
  authors = ["Lucas Amaro <lucasrla@users.noreply.github.com>"]

  [tool.poetry.dependencies]
  python = "^3.8"

  [tool.poetry.dev-dependencies]

  [build-system]
  requires = ["poetry>=0.12"]
  build-backend = "poetry.masonry.api"


  Do you confirm generation? (yes/no) [yes]
```

### poetry new

Alternatively, use `poetry new` for quick project scaffolding:

```sh
poetry new PROJECT_NAME
  Created package project_name in PROJECT_NAME

tree PROJECT_NAME -L 2
  PROJECT_NAME
  ├── README.rst
  ├── project_name
  │   └── __init__.py
  ├── pyproject.toml
  └── tests
      ├── __init__.py
      └── test_project_name.py

  2 directories, 5 files

cat PROJECT_NAME/pyproject.toml
  [tool.poetry]
  name = "PROJECT_NAME"
  version = "0.1.0"
  description = ""
  authors = ["Lucas Amaro <lucasrla@users.noreply.github.com>"]

  [tool.poetry.dependencies]
  python = "^3.8"

  [tool.poetry.dev-dependencies]
  pytest = "^5.2"

  [build-system]
  requires = ["poetry>=0.12"]
  build-backend = "poetry.masonry.api"
```

### poetry env info

```sh
poetry env info

  Virtualenv
  Python:         3.8.2
  Implementation: CPython
  Path:           /Users/<USER_NAME>/.pyenv/versions/3.8.2/envs/venv-test
  Valid:          True

  System
  Platform: darwin
  OS:       posix
  Python:   /Users/<USER_NAME>/.pyenv/versions/3.8.2
```

For detailed information about how to use `poetry`, read [the official docs](https://python-poetry.org/docs/).


## From Pipenv to poetry with poetrify

poetrify makes it easy to go from Pipenv's `Pipfile` or Pip's `requirements.txt` (still experimental) to poetry's `pyproject.toml`. Repository [here](https://github.com/kk6/poetrify).

It is possible to run poetrify with pipx quite conveniently:

```sh
# inside a directory with a Pipfile:
pipx run poetrify generate
```

This will get us the equivalent of a `poetry init` command (including the interactivity!).