---
title: Extensions
parent: jupyter
nav_order: 2
---

# JupyterLab Extensions (labextensions)
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

<div class="warning-box">We must have Node.js installed in order to install any JupyterLab Extension. If you haven't installed it yet, <a href="https://lucasrla.github.io/macos-setup/node-js/nvm.html">read the setup instructions here</a>.</div>

## jupyterlab-manager

Let's first install the `labextension` manager:

```sh
jupyter labextension list
  JupyterLab v2.1.4
  No installed extensions

jupyter labextension install @jupyter-widgets/jupyterlab-manager

jupyter labextension list
  JupyterLab v2.1.4
  Known labextensions:
    app dir: /Users/<USER_NAME>/.local/pipx/venvs/jupyterlab/share/jupyter/lab
          @jupyter-widgets/jupyterlab-manager v2.0.0  enabled  OK
```

## katex-extension: a renderer for KaTeX

[KaTeX](https://katex.org) is an lighter alternative to [MathJax](https://www.mathjax.org):

```sh
# https://github.com/jupyterlab/jupyter-renderers/tree/master/packages/katex-extension
jupyter labextension install @jupyterlab/katex-extension

jupyter labextension list
  JupyterLab v2.1.4
  Known labextensions:
    app dir: /Users/<USER_NAME>/.local/pipx/venvs/jupyterlab/share/jupyter/lab
          @jupyterlab/katex-extension v2.0.0  enabled  OK
```

## fasta-extension: a renderer for FASTA

[FASTA](https://en.wikipedia.org/wiki/FASTA_format) is a text-based format for representing either nucleotide sequences or amino acid (protein) sequences:

```sh
# https://github.com/jupyterlab/jupyter-renderers/tree/master/packages/fasta-extension
jupyter labextension install @jupyterlab/fasta-extension

jupyter labextension list
  JupyterLab v2.1.4
  Known labextensions:
    app dir: /Users/<USER_NAME>/.local/pipx/venvs/jupyterlab/share/jupyter/lab
          @jupyterlab/fasta-extension v2.0.0  enabled  OK
```

## Collapsible headings

> Make headings collapsible like the old Jupyter notebook extension and like Mathematica notebooks.

```sh
# https://github.com/aquirdTurtle/Collapsible_Headings
jupyter labextension install @aquirdturtle/collapsible_headings

jupyter labextension list
  JupyterLab v2.1.4
  Known labextensions:
    app dir: /Users/<USER_NAME>/.local/pipx/venvs/jupyterlab/share/jupyter/lab
          @aquirdturtle/collapsible_headings v2.2.0  enabled  OK
```

---

Continue reading: [JupyterLab Plugins](plugins.html).