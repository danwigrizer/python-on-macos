---
title: Plugins
parent: jupyter
nav_order: 3
---

# JupyterLab Plugins
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

<div class="warning-box">Before installing the plugins listed below, you should first install the <code class="language-plaintext highlighter-rouge">jupyterlab-manager labextension</code>. If you haven't installed it yet, <a href="labextensions.html">read the setup instructions here</a>.</div>

## Overview of Python plotting libraries

For a fairly comprehensive list of plotting libraries for Python, [read this section](https://github.com/altair-viz/altair#project-philosophy) of Altair's docs.

## ipywidgets

From the [official repository](https://github.com/jupyter-widgets/ipywidgets):

> ipywidgets are interactive HTML widgets for Jupyter notebooks, JupyterLab and the IPython kernel.

```sh
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

pipx inject jupyterlab ipywidgets

jupyter --version
  jupyter core     : 4.6.3
  jupyter-notebook : 6.0.3
  qtconsole        : not installed
  ipython          : 7.15.0
  ipykernel        : 5.3.0
  jupyter client   : 6.1.3
  jupyter lab      : 2.1.4
  nbconvert        : 5.6.1
  ipywidgets       : 7.5.1
  nbformat         : 5.0.6
  traitlets        : 4.3.3
```

## Voilà

From the [official repository](https://github.com/voila-dashboards/voila):

> Voilà turns Jupyter notebooks into standalone web applications. Unlike the usual HTML-converted notebooks, each user connecting to the Voilà tornado application gets a dedicated Jupyter kernel which can execute the callbacks to changes in Jupyter interactive widgets.

```sh
which voila
  voila not found

pipx inject jupyterlab voila --include-apps
  installed package voila 0.1.21, Python 3.8.2
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
    - voila
  done! ✨ 🌟 ✨
  injected package voila into venv jupyterlab
  done! ✨ 🌟 ✨

which voila
  /Users/<USER_NAME>/.local/bin/voila
```

Voilà also provides a labextension that displays a Voilà preview of your notebook in a side-pane:

```sh
jupyter labextension install @jupyter-voila/jupyterlab-preview

jupyter labextension list
  JupyterLab v2.1.4
  Known labextensions:
    app dir: /Users/<USER_NAME>/.local/pipx/venvs/jupyterlab/share/jupyter/lab
          @jupyter-voila/jupyterlab-preview v1.1.0  enabled  OK
```

Voilà can also be used as a standalone app. Read [their official docs for the instructions](https://voila.readthedocs.io/en/stable/index.html).


## Altair

From the [official repository](https://github.com/altair-viz/altair):

> Altair is a declarative statistical visualization library for Python based on Vega and Vega-Lite.

```sh
pipx inject jupyterlab altair vega_datasets
  injected package altair into venv jupyterlab
  done! ✨ 🌟 ✨
  injected package vega_datasets into venv jupyterlab
  done! ✨ 🌟 ✨
```

Great! Altair is now available inside our default kernel (`/Users/<USER_NAME>/.local/pipx/venvs/jupyterlab/bin/python`). It has also installed several useful Python packages into the default environment: entrypoints, jsonschema, NumPy,  Pandas, and Toolz.

Bonus: [check out the Altair's gallery for many impressive showcase examples](https://altair-viz.github.io/gallery/index.html).


## Bokeh

Install the nice [Bokeh library](https://bokeh.org):

```sh
pipx inject jupyterlab bokeh
  injected package bokeh into venv jupyterlab
  done! ✨ 🌟 ✨
```

And then its [labextension](https://github.com/bokeh/jupyter_bokeh):

```sh
# @jupyter-widgets/jupyterlab-manager is a dependency that must be installed before jupyter_boker
# we have it commented out below because we have already installed it
# jupyter labextension install @jupyter-widgets/jupyterlab-manager

jupyter labextension install @bokeh/jupyter_bokeh

jupyter labextension list
  JupyterLab v2.1.4
  Known labextensions:
    app dir: /Users/<USER_NAME>/.local/pipx/venvs/jupyterlab/share/jupyter/lab
          @bokeh/jupyter_bokeh v2.0.2  enabled  OK
```

Follow this issue to check if things change and get simpler in the future [(#105)](https://github.com/bokeh/jupyter_bokeh/issues/105).

Like Altair, Bokeh also has a great gallery of examples. [Check it out](https://docs.bokeh.org/en/latest/docs/gallery.html).


## bqplot

From the [official repository](https://github.com/bqplot/bqplot):

> bqplot is a 2-D visualization system for Jupyter, based on the constructs of the Grammar of Graphics.

You know the drill:

```sh
pipx inject jupyterlab bqplot
  injected package bqplot into venv jupyterlab
  done! ✨ 🌟 ✨
```

And:

```sh
# @jupyter-widgets/jupyterlab-manager is a dependency that must be installed beforehand
# jupyter labextension install @jupyter-widgets/jupyterlab-manager

jupyter labextension install bqplot

jupyter labextension list
  JupyterLab v2.1.4
  Known labextensions:
    app dir: /Users/<USER_NAME>/.local/pipx/venvs/jupyterlab/share/jupyter/lab
          bqplot v0.5.12  enabled  OK
```