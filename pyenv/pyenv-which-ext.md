---
title: pyenv-which-ext
parent: pyenv
nav_order: 3
---

# pyenv-which-ext
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

A side-effect of pyenv architecture is the risk of its shims taking over, especially with conda. The [pyenv-which-ext](https://github.com/pyenv/pyenv-which-ext) is the solution to this problem.

For more information, read this [thread on pyenv repository](https://github.com/pyenv/pyenv/pull/992). Make sure you do not miss this comment by [@yyuu](https://github.com/pyenv/pyenv/pull/992#issuecomment-333008248): 

> Fallback to non-pyenv executables if the given command was not found in active pyenv versions

## Install pyenv-which-ext from Homebrew

```sh
brew install pyenv-which-ext
  [...]
  ==> Installing pyenv-which-ext
  ==> ./install.sh
  🍺  /usr/local/Cellar/pyenv-which-ext/0.0.2: 5 files, 6.5KB, built in 4 seconds

# to enable pyenv-which-ext restart zsh (or open a new window/tab)
exec "$SHELL"
```


## Anecdote: my own experience with ghostscript

I had ghostscript installed in a `conda` environment (`gs` is a `libvips` dependency). When I decided to install `gs` via `brew` a few weeks later, I could not access it from `PATH`: 

```sh
which gs
  /Users/lucas/.pyenv/shims/gs

gs --help
  pyenv: gs: command not found

  The `gs` command exists in these Python versions:
    miniconda3-4.7.12/envs/vips

  Note: See 'pyenv help global' for tips on allowing both
        python2 and python3 to be found.
```

This was happening because pyenv shims are on top of my `PATH`, and therefore with precedence over Homebrew's `/usr/local`.

```sh
echo $PATH
  /Users/<USER_NAME>/.local/bin:/Users/<USER_NAME>/.pyenv/plugins/pyenv-virtualenv/shims:/Users/lucas/.pyenv/shims:/Users/<USER_NAME>/.nvm/versions/node/v14.4.0/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin

brew info ghostscript
  ghostscript: stable 9.52 (bottled), HEAD
  Interpreter for PostScript and PDF
  https://www.ghostscript.com/
  /usr/local/Cellar/ghostscript/9.52 (671 files, 87.4MB) *
    Poured from bottle on 2020-07-31 at 18:24:55
  From: https://github.com/Homebrew/homebrew-core/blob/HEAD/Formula/ghostscript.rb
  License: AGPL-3.0

ls -lah /usr/local/bin/gs
  [...] /usr/local/bin/gs -> ../Cellar/ghostscript/9.52/bin/gs

pyenv which gs
  pyenv: gs: command not found

  The `gs` command exists in these Python versions:
    miniconda3-4.7.12/envs/vips

  Note: See 'pyenv help global' for tips on allowing both
        python2 and python3 to be found.

pyenv which python
  /Users/<USER_NAME>/.pyenv/versions/3.8.2/bin/python
```

Fortunately, the problem is now gone after having `pyenv-which-ext` installed:

```sh
which gs
  /Users/<USER_NAME>/.pyenv/shims/gs

pyenv which gs
  /usr/local/bin/gs

gs --version
  9.52
```


## Inspecting the shims directory

If you are interested in what is going on under the hood with `pyenv`, check out the `shims` directory. Every Python command in every installed version of Python is there:

```sh
tree $HOME/.pyenv/shims -L 1
  [...]
```
