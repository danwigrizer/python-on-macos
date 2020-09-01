---
title: pipx
nav_order: 3
---

# pipx
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

pipx brings us the best of two worlds:

1. It lets us install globally available Python-based apps – like `youtube-dl`

2. It prevents those apps’ dependencies from messing up with our global Python installation

If you come from the Node.js world, `pipx` is Python's version of `npx`.

For more on pipx, read [the docs](https://pipxproject.github.io/pipx/comparisons/). And here's a [link to their official GitHub repository](https://github.com/pipxproject/pipx).

## Install pipx from pip

<div class="warning-box">Before installing pipx you must install and configure pyenv first. <a href="pyenv/pyenv.html">Read the setup instructions here</a>.</div>

`pipx` is available for installation through `brew`, but because we are avoiding Homebrew's `python`, let's use `pip` to install `pipx` instead.

_Please note that pipx requires Python >= `3.6`._

```sh
which python
  /Users/<USER_NAME>/.pyenv/shims/python

python --version
  Python 3.8.2

pip -V
  pip 19.2.3 from /Users/<USER_NAME>/.pyenv/versions/3.8.2/lib/python3.8/site-packages/pip (python 3.8)

python -m pip install --user pipx
  WARNING: The script userpath is installed in '/Users/<USER_NAME>/.local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
  WARNING: The script pipx is installed in '/Users/<USER_NAME>/.local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
```

## Set pipx's directory to the top of PATH

Add `/Users/<USER_NAME>/.local/bin` to the top of our `PATH`. This is crucial. 

Otherwise, we will have issues with `pyenv` and `pyenv-virtualenv`. If you want to read why `pyenv` can become a `PATH` nightmare, see [(#1112)](https://github.com/pyenv/pyenv/issues/1112).

```sh
# the line below will be the last one in your .zshrc
echo 'export PATH="/Users/<USER_NAME>/.local/bin:$PATH"' >> ~/.zshrc

# restart zsh
exec "$SHELL"

which pipx
  /Users/<USER_NAME>/.local/bin/pipx

pipx list
  nothing has been installed with pipx 😴

pipx --version
  0.15.4.0
```

## Install shell completions

To enable completions add the following lines to `~/.zshrc` (or `~/.preztorc`):

```sh
# pipx completions
autoload -U bashcompinit
bashcompinit
eval "$(register-python-argcomplete pipx)"
```

## Upgrade pipx via pip

```sh
python -m pip install --user -U pipx

pipx --version
  0.15.5.1
```

## Potential issues when upgrading pyenv's python

Note that we have installed `pipx` using the `python 3.8.2` provided by `pyenv`. In case we get rid of that version (please, don't!), things could go awry.

The solution for such issues most likely are `pipx reinstall-all`, possibly with flag `--python xxx`:

> Reinstalls all packages. Packages are uninstalled, then installed with `pipx install PACKAGE` with the same options used in the original install of `PACKAGE`. This is useful if you upgraded to a new version of Python and want all your packages to use the latest as well.

For more information, read [the docs](https://pipxproject.github.io/pipx/docs/#pipx-reinstall-all), [issue #113](https://github.com/pipxproject/pipx/issues/113), and especially [issue #146](https://github.com/pipxproject/pipx/issues/146).


## Basic usage

Using `pipx` we can run a binary a single time in a virtual environment. After the execution the virtual environment and all installed dependencies are removed. Call it one-shot use:

```sh
pipx run pycowsay haha
    ----
  < haha >
    ----
    \   ^__^
      \  (oo)\_______
        (__)\       )\/\
            ||----w |
            ||     ||
```

The common operations are pretty straightforward:

```sh
pipx install pycowsay
  installed package pycowsay 0.0.0.1, Python 3.8.2
  These apps are now globally available
    - pycowsay
  done! ✨ 🌟 ✨

 pipx list
  venvs are in /Users/<USER_NAME>/.local/pipx/venvs
  apps are exposed on your $PATH at /Users/<USER_NAME>/.local/bin
    package pycowsay 0.0.0.1, Python 3.8.2
      - pycowsay

pipx uninstall pycowsay
  uninstalled pycowsay! ✨ 🌟 ✨
```

## Advantage usage

Here are a few more advanced operations:

```sh
# list all packages installed with pipx, including additional packages that had been injected
pipx list --include-injected
  [...]

# equivalent of running `pip list` inside the jupyterlab virtualenv
pipx runpip jupyterlab list
  [...]
```
