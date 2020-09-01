---
title: pyenv global
parent: Combining them all
nav_order: 1
---

# pyenv global

## Set the latest Python 3, miniconda, and Python 2.7.18 as our global

You might recall that [during our miniconda setup we have experienced the following](/python-on-macos/conda/miniconda.html#install-miniconda-via-pyenv):

```sh
conda list
  zsh: command not found: conda

conda --version
  zsh: command not found: conda

pyenv which conda
  pyenv: conda: command not found

  The `conda` command exists in these Python versions:
    miniconda3-4.7.12

  Note: See 'pyenv help global' for tips on allowing both
        python2 and python3 to be found.

pyenv versions --skip-aliases
* system (set by /Users/<USER_NAME>/.pyenv/version)
  2.7.18
  3.8.2
  miniconda3-4.7.12
```

The solution for this issue is easy:

```sh
pyenv global --help
  Usage: pyenv global <version> <version2> <..>

  Sets the global Python version(s). You can override the global version at
  any time by setting a directory-specific version with `pyenv local`
  or by setting the `PYENV_VERSION` environment variable.

  <version> can be specified multiple times and should be a version
  tag known to pyenv.  The special version string `system` will use
  your default system Python.  Run `pyenv versions` for a list of
  available Python versions.

  Example: To enable the python2.7 and python3.7 shims to find their
          respective executables you could set both versions with:

  'pyenv global 3.7.0 2.7.15'
```

So, let's have both Python 3 **and** miniconda **and** Python 2 (just in case) in this exact order as our global pyenv versions:

```sh
pyenv global 3.8.2 miniconda3-4.7.12 2.7.18

pyenv versions --skip-aliases
  system
* 2.7.18 (set by /Users/<USER_NAME>/.pyenv/version)
* 3.8.2 (set by /Users/<USER_NAME>/.pyenv/version)
* miniconda3-4.7.12 (set by /Users/<USER_NAME>/.pyenv/version)

# the first and foremost python will be pyenv's 3.8.2
pyenv which python
  /Users/<USER_NAME>/.pyenv/versions/3.8.2/bin/python

# no more Apple's default for Python 2
pyenv which python2
  /Users/<USER_NAME>/.pyenv/versions/2.7.18/bin/python2

# conda is now reachable!
conda --version
  conda 4.7.12

pyenv which conda
  /Users/<USER_NAME>/.pyenv/versions/miniconda3-4.7.12/bin/conda
```
