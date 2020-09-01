---
title: Homebrew's Python
parent: Combining them all
nav_order: 4
---

# Dealing with Homebrew's Python

If you are a dev using macOS it is inevitable that you will have Homebrew's Python installed as a dependency.

From [Homebrew's official docs](https://docs.brew.sh/Homebrew-and-Python):

> Why is Homebrew’s Python being installed as a dependency?
> 
> Formulae that declare an unconditional dependency on the "python" formula are bottled against Homebrew’s Python 3.x and require it to be installed.

How to deal with that?

Simply ignore it. Let Homebrew do its thing. We will not touch its Python.

If we are going to use Homebrew (and of course we will use it!), then I guess we will need to accept their behavior. At least their Python is self-contained and will be used only for things you install with `brew`. 

```sh
brew info python
  python@3.8: stable 3.8.5 (bottled)
  Interpreted, interactive, object-oriented programming language
  https://www.python.org/
  /usr/local/Cellar/python@3.8/3.8.5 (4,408 files, 68.2MB) *
    Poured from bottle on 2020-07-23 at 14:19:00
  From: https://github.com/Homebrew/homebrew-core/blob/HEAD/Formula/python@3.8.rb
  License: Python-2.0
  ==> Dependencies
  Build: pkg-config ✔
  Required: gdbm ✔, openssl@1.1 ✔, readline ✔, sqlite ✘, xz ✔
  ==> Caveats
  Python has been installed as
    /usr/local/bin/python3

  Unversioned symlinks `python`, `python-config`, `pip` etc. pointing to
  `python3`, `python3-config`, `pip3` etc., respectively, have been installed into
    /usr/local/opt/python@3.8/libexec/bin

  You can install Python packages with
    pip3 install <package>
  They will install into the site-package directory
    /usr/local/lib/python3.8/site-packages

  See: https://docs.brew.sh/Homebrew-and-Python

pyenv which python3
  /Users/<USER_NAME>/.pyenv/versions/3.8.2/bin/python3

pyenv which pip3
  /Users/<USER_NAME>/.pyenv/versions/3.8.2/bin/pip3

/usr/local/bin/python3 --version
  Python 3.8.5

tree -L 1 /usr/local/lib/python3.8/site-packages
  /usr/local/lib/python3.8/site-packages
  ├── __pycache__
  ├── easy_install.py
  ├── pip
  ├── pip-20.1.1-py3.8.egg-info
  ├── pkg_resources
  ├── setuptools
  ├── setuptools-49.2.0-py3.8.egg-info
  ├── sitecustomize.py
  ├── wheel
  └── wheel-0.34.2-py3.8.egg-info

  8 directories, 2 files
```