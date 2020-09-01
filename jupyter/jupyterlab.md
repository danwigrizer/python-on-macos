---
title: JupyterLab
parent: jupyter
nav_order: 1
---

# JupyterLab
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

From the [official website](https://jupyter.org):

> JupyterLab is a web-based interactive development environment for Jupyter notebooks, code, and data. JupyterLab is flexible: configure and arrange the user interface to support a wide range of workflows in data science, scientific computing, and machine learning. JupyterLab is extensible and modular: write plugins that add new components and integrate with existing ones.

## Install jupyterlab via pipx

<div class="warning-box">Before installing JupyterLab, you must install and configure pipx first. <a href="/python-on-macos/pipx.html">Read the setup instructions here</a>.</div>

We want our `jupyter` installation to be unique and globally acessible. `pipx` is the perfect tool for that.

```sh
pipx install jupyterlab --include-deps
  installed package jupyterlab 2.1.4, Python 3.8.2
  These apps are now globally available
    - chardetect
    - iptest
    - iptest3
    - ipython
    - ipython3
    - jlpm
    - jsonschema
    - jupyter
    - jupyter-bundlerextension
    - jupyter-kernel
    - jupyter-kernelspec
    - jupyter-lab
    - jupyter-labextension
    - jupyter-migrate
    - jupyter-nbconvert
    - jupyter-nbextension
    - jupyter-notebook
    - jupyter-run
    - jupyter-serverextension
    - jupyter-troubleshoot
    - jupyter-trust
    - pygmentize
    - pyjson5
  done! ✨ 🌟 ✨

which jupyter
  /Users/<USER_NAME>/.local/bin/jupyter

jupyter --version
  jupyter core     : 4.6.3
  jupyter-notebook : 6.0.3
  qtconsole        : not installed
  ipython          : 7.15.0
  ipykernel        : 5.3.0
  jupyter client   : 6.1.3
  jupyter lab      : 2.1.4
  nbconvert        : 5.6.1
  ipywidgets       : not installed
  nbformat         : 5.0.6
  traitlets        : 4.3.3

which jupyter-lab
  /Users/<USER_NAME>/.local/bin/jupyter-lab

which jupyter-notebook
  /Users/<USER_NAME>/.local/bin/jupyter-notebook

which ipython
  /Users/<USER_NAME>/.local/bin/ipython
```

Please note that we have used a special flag, `--include-deps`. Do not forget to use it. 

If we miss it, we won't get all apps properly linked by `pipx`. See [#18](https://github.com/pipxproject/pipx/issues/18) and [#145](https://github.com/pipxproject/pipx/issues/143).


## jupyter across the filesystem

Where do `jupyter` files live?

```sh
jupyter --paths
  config:
      /Users/<USER_NAME>/.jupyter
      /Users/<USER_NAME>/.pyenv/versions/3.8.2/etc/jupyter
      /usr/local/etc/jupyter
      /etc/jupyter
  data:
      /Users/<USER_NAME>/Library/Jupyter
      /Users/<USER_NAME>/.pyenv/versions/3.8.2/share/jupyter
      /usr/local/share/jupyter
      /usr/share/jupyter
  runtime:
      /Users/<USER_NAME>/Library/Jupyter/runtime

tree ~/.jupyter -L 1
  /Users/<USER_NAME>/.jupyter
  └── lab

  1 directory, 0 files

tree ~/Library/Jupyter -L 1
  /Users/<USER_NAME>/Library/Jupyter
  └── runtime

  1 directory, 0 files
```

## Turn the dark mode on

To go dark the first time you run `jupyter lab`, on the top-level menu, select `Settings > JupyterLab Theme > JupyterLab Dark`.


## Plugins and extensions

To take our jupyter setup to the next level, let's install some plugins and extensions. [Read the instructions here](labextensions.html).