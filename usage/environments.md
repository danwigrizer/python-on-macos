---
title: Environments
parent: Combining them all
nav_order: 2
---

# Managing environments
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Recipe for Python virtualenvs

Here are the steps for creating and managing virtualenvs (that are also compatible with poetry):

```sh
# 1. Create a virtualenv using the foremost version of pyenv global (3.8.2 in our case)
pyenv virtualenv my-venv

# 2. Set the virtualvenv to your project directory using pyenv local
cd YOUR_PROJECT_DIR && pyenv local my-venv

# 3. Install whatever you want with either pip or poetry
pip install -r requirements.txt
poetry install

# 4. If/when done with the env, delete it with pyenv virtualenv-delete
pyenv virtualenv-delete my-venv
```

## A longer example with comments

Let's start by creating a new `virtualenv` called `venv-test` using Python `3.7.7`:

```sh
cd test-project

pyenv virtualenv 3.7.7 venv-test
  [...]

pyenv virtualenvs
  3.7.7/envs/venv-test (created from /Users/<USER_NAME>/.pyenv/versions/3.7.7)
  venv-test (created from /Users/<USER_NAME>/.pyenv/versions/3.7.7)
  # these two entries are the same thing, the shorter is just a symlink to the other

tree -L 1 ~/.pyenv/versions
  /Users/<USER_NAME>/.pyenv/versions
  ├── 3.7.7
  ├── 3.8.2
  └── venv-test -> /Users/<USER_NAME>/.pyenv/versions/3.7.7/envs/venv-test

  3 directories, 0 files
```

Unlike the manually-managed virtual envs, `pyenv-virtualenv` consolidates all our virtual environments in one directory (`~/.pyenv/versions/<python-version>/envs/`) rather than scattering them throughout your project files. This is nice, but it also means you can't name all of them `venv` anymore. So, here's [a tip on choosing names for `virtualenvs`](https://medium.com/swlh/a-guide-to-python-virtual-environments-8af34aa106ac#6ca5):

> I name my environments `venv-<PROJECT_NAME>`. That makes them easy to organize and helps maintain compatibility with older `.gitignore` files that generally assume `venv` is the name of your virtual environment.

Because we have installed and configured `pyenv-virtualenv` ([instructions are here](/python-on-macos/pyenv/pyenv-virtualenv.html)), we can set a virtual environment using the `pyenv local` command and have `pyenv-virtualenv` auto-activate the right environments as you switch to different directories:

```sh
cd test-project

ls 
# it is empty

pyenv version
  3.8.2 (set by /Users/<USER_NAME>/.pyenv/version)

pyenv local venv-test

# pyenv local creates a .python-version file
ls
  .python-version

pyenv version
  venv-test (set by /Users/<USER_NAME>/test-project/.python-version)

cat .python-version
  venv-test
```

## Recipe for Conda environments

If your project have dependencies that fit conda packages better than plain Pip packages, then use a conda environment. Here are the steps for creating and managing conda environments:

```sh
# 1. Start with conda create (in this case installing libvips from conda-forge)
conda --create vips-conda-env --channel conda-forge libvips

# 2. Then use pyenv local to set a pyenv virtualenv locally
cd CONDA_PROJECT_DIR && pyenv local vips-conda-env

# 3. If/when done with the env, delete it with pyenv virtualenv-delete
pyenv virtualenv-delete vips-conda-env
```

## Other useful commands

Commands for managing enviroments:

```sh
# list all virtualenvs and conda environments in your machine
# note: for virtualenvs created with pyenv-virtualenvs, there will be two entries
#       they are the same virtualenv, the shorter one is just a symlink to the other one
pyenv virtualenvs

# list all packages installed in a conda environment
conda list

# list packages installed with conda by "commit"/revision
conda list --revisions

# rollback to a specific "commit"/revision
conda install --revision 1

# print out information about the environment as "perceived" by poetry
poetry env info

# remove the .python-local file in a given directory
pyenv local --unset

# remove index cache, lock files, unused cache packages, and tarballs
conda clean --all

# remove cached package tarballs
conda clean --tarballs

# create an environment with R (and no python!)
conda create -n conda-r-env r-base r-essentials --no-default-packages

# export your conda environment
# - see also: https://stackoverflow.com/a/56240425
conda env export --file environment.yml
```