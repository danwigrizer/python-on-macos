---
title: pyenv-virtualenv
parent: pyenv
nav_order: 2
---

# pyenv-virtualenv
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

From the [official pyenv repository](https://github.com/pyenv/pyenv#managing-virtual-environments):

> There is a `pyenv` plugin named `pyenv-virtualenv` which comes with various features to help `pyenv` users to manage virtual environments created by `virtualenv` or `Anaconda`. Because the activate script of those virtual environments are relying on mutating `$PATH` variable of user's interactive shell, it will intercept `pyenv`'s shim style command execution hooks. We'd recommend to install `pyenv-virtualenv` as well if you have some plan to play with those virtual environments.

For more information on pyenv-virtualenv, check out [their repository](https://github.com/pyenv/pyenv-virtualenv).

## Install pyenv-virtualenv

```sh
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv

# to enable pyenv-virtualenv restart zsh (or open a new window/tab)
exec "$SHELL"
```

It seems also [possible to install via Homebrew](https://github.com/pyenv/pyenv-virtualenv#installing-with-homebrew-for-macos-users), but I haven't tried it yet.


## Configure auto-activation

To enable auto-activation, add to [`zsh` config](https://unix.stackexchange.com/questions/71253/what-should-shouldnt-go-in-zshenv-zshrc-zlogin-zprofile-zlogout) (e.g. `~/.zshrc`) the following line:

```sh
eval "$(pyenv virtualenv-init -)"
```

In other words, to auto activate (and deactivate) `virtualenvs` upon entering (and leaving) directories that contain a pyenv's `.python-version` file, you should have the following lines at the end of `~/.zshrc`:

```sh
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)";
  eval "$(pyenv virtualenv-init -)"; 
fi
```

There is a downside to auto-activation, though. The auto-switch seems to slow `zsh` down quite a bit. For more information on this, read [#132](https://github.com/pyenv/pyenv-virtualenv/issues/132) and [#259](https://github.com/pyenv/pyenv-virtualenv/issues/259).

In case you decide to stay away from auto-activation, you can activate and deactivate manually:

```sh
pyenv activate <YOUR_VENV_NAME>
pyenv deactivate
```

If when using `pyenv activate` you see the following message: `pyenv-virtualenv: prompt changing will be removed from future release`, then follow this issue [#135](https://github.com/pyenv/pyenv-virtualenv/issues/135) to understand what is going on.


## Delete a virtualenv

```sh
pyenv virtualenv-delete venv-test
  pyenv-virtualenv: remove /Users/<USER_NAME>/.pyenv/versions/3.7.7/envs/venv-test? y

# this also works:
pyenv uninstall venv-test2
  pyenv-virtualenv: remove /Users/<USER_NAME>/.pyenv/versions/3.8.2/envs/venv-test2? y
```

Note that removing a `virtualenv` does not remove the references to it from `.python-version` files inside project directories. For instance:

```sh
cd test-project

cat .python-version
  venv-test

pyenv activate venv-test
  pyenv: version `venv-test` is not installed (set by /Users/<USER_NAME>/dev/test-project/.python-version)
```