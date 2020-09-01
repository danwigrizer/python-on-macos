---
title: pyenv
parent: pyenv
nav_order: 1
---

# pyenv
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

Installing and configuring pyenv is the first step in our Python setup journey. pyenv is really the cornerstone of my Python setup.

We will install [pyenv](https://github.com/pyenv/pyenv) to maintain sanity while managing multiple Python versions and environments. pyenv was heavily inspired by `rbenv` (for Ruby), and in many ways is similar to `nvm` (for Node.js) as well.

At a high level, `pyenv` first intercepts Python commands using [`shim` executables](https://en.wikipedia.org/wiki/Shim_(computing)) that are injected into `PATH`; it then determines which Python version has been specified; and finally it passes your commands along to the correct Python installation.

Besides the official docs, the best guide to pyenv I could find is [this one by the folks at RealPython](https://realpython.com/intro-to-pyenv/).

## Install the dependencies in advance

```sh
# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
brew update && brew install readline sqlite3 xz zlib
```

Caveats regarding `readline`:

> `readline` is keg-only, which means it was not symlinked into `/usr/local`, because macOS provides BSD `libedit`.
>
> For compilers to find `readline` you may need to set:
> ```zsh
>  export LDFLAGS="-L/usr/local/opt/readline/lib"
>  export CPPFLAGS="-I/usr/local/opt/readline/include"
> ```

Caveats regarding `sqlite`:

> `sqlite` is keg-only, which means it was not symlinked into `/usr/local`, because macOS already provides this software and installing another version in parallel can cause all kinds of trouble.
>
> If you need to have `sqlite` first in your `PATH` run: `echo 'export PATH="/usr/local/opt/sqlite/bin:$PATH"' >> ~/.zshrc`
>
> For compilers to find `sqlite` you may need to set:
> ```zsh
>  export LDFLAGS="-L/usr/local/opt/sqlite/lib"
>  export CPPFLAGS="-I/usr/local/opt/sqlite/include"
> ```
> For `pkg-config` to find `sqlite` you may need to set:
> ```zsh
>  export PKG_CONFIG_PATH="/usr/local/opt/sqlite/lib/pkgconfig"
> ```

Caveats regarding `zlib`:

> `zlib` is keg-only, which means it was not symlinked into `/usr/local`, because macOS already provides this software and installing another version in parallel can cause all kinds of trouble.
> 
> For compilers to find `zlib` you may need to set:
> ```zsh
>  export LDFLAGS="-L/usr/local/opt/zlib/lib"
>  export CPPFLAGS="-I/usr/local/opt/zlib/include"
> ```
>
> For `pkg-config` to find `zlib` you may need to set:
> ```zsh
>  export PKG_CONFIG_PATH="/usr/local/opt/zlib/lib/pkgconfig"
> ```

## Install pyenv via Homebrew

```sh
brew update && brew install pyenv

which pyenv
  /usr/local/bin/pyenv

ls -al /usr/local/bin/pyenv
  [...] /usr/local/bin/pyenv -> ../Cellar/pyenv/1.2.18/bin/pyenv
```

As of `2020-05-29`, the `pyenv` version installed was `1.2.18`. The Homebrew formula is [available here](https://github.com/Homebrew/homebrew-core/blob/566560476be4973d396c54e920411b07081b6722/Formula/pyenv.rb).

## Install zsh completions

Add `pyenv init` to your `zsh` to enable shims and autocompletion. 

Please make sure `eval "$(pyenv init -)"` is placed toward the end of the shell configuration file (`~/.zshrc`) because it manipulates `PATH` during the initialization:

```sh
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.zshrc

# checking if pyenv's shims directory is in PATH
echo $PATH | grep --color=auto "$(pyenv root)/shims"
  /Users/<USER_NAME>/.pyenv/shims:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin
```

Let's now check if it is working fine:

```sh
pyenv --version
  pyenv 1.2.18

pyenv versions
* system (set by /Users/<USER_NAME>/.pyenv/version)

which python
  /Users/<USER_NAME>/.pyenv/shims/python

pyenv which python
  /usr/bin/python

tree /Users/<USER_NAME>/.pyenv/ -L 1
  /Users/<USER_NAME>/.pyenv/
  ├── shims
  └── versions

  2 directories, 0 files

pyenv root
  /Users/<USER_NAME>/.pyenv
```

## Install the latest stable Python 3

Print out the full list of Python versions available via pyenv:

```sh
pyenv install --list

# you will see a long list with tons of versions:
# 2.x.x, 3.x.x, activepython, anaconda, ironpython, jython, 
# micropython, miniconda3, pypy, pyston, stackless
```

Install the latest stable version of `python3` available (`3.8.2` at the time):

```sh
pyenv install 3.8.2
  [...]

pyenv versions
* system (set by /Users/<USER_NAME>/.pyenv/version)
  3.8.2
```

## Install Python 2.7.18

It is well known that Python 2 is now discontinued – no more security patches or other improvements will be released for it. But in case you have old code that is only compatible with Python 2, it is handy to have it available via pyenv. 

So, let's install the [2.7.18 version, a.k.a. the last release of Python 2](https://pythoninsider.blogspot.com/
2020/04/python-2718-last-release-of-python-2.html):

```sh
# 2.7.18 is a unique, commemorative Python release :)
pyenv install 2.7.18
  [...]

pyenv versions --skip-aliases
  [...]
```

Please keep in mind that, despite having just installed `2.7.18` via pyenv, `zsh` will still pick `python2` from Apple's default Python installation:

```sh
which python2
  /Users/<USER_NAME>/.pyenv/shims/python2

pyenv which python2
  /usr/bin/python2
```

Note: we will solve this "issue" later on via `pyenv global`. [Read it here](/usage/pyenv-global.html).

## Delete a Python version

Simply use `pyenv uninstall`:

```sh
pyenv versions
  system
  3.7.7
* 3.8.2 (set by /Users/<USER_NAME>/.pyenv/version)

pyenv uninstall 3.7.7
  pyenv: remove /Users/<USER_NAME>/.pyenv/versions/3.7.7? y

pyenv versions
  system
* 3.8.2 (set by /Users/<USER_NAME>/.pyenv/version)
```

## Tip: pyenv rehash

After deleting a Python version (or after installing/deleting a `virtualenv` that had lots of libraries inside it), it might be a good idea to run:

```sh
pyenv rehash

pyenv --help
   rehash      Rehash pyenv shims (run this after installing executables)
```

## Keep pyenv updated

In order to use the latest Python (and miniconda) versions, we will need to upgrade pyenv regularly:

```sh
brew update && brew upgrade pyenv
```

For the list of versions that are included in each release of pyenv, check out [the official repository](https://github.com/pyenv/pyenv/releases).