---
title: Kernels
parent: Combining them all
nav_order: 3
---

# Managing Jupyter kernels
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Shell script for creating kernels from virtualenvs

For a virtualenv or conda environment to be used in a Jupyter notebook, we need to make it available to jupyter through a kernel.

I have created a shell script (heavily inspired on a [gist by @thvitt](https://gist.github.com/thvitt/9072336288921f57ec8741eb4b8b024e)) that installs `ipykernel` into the active virtualenv and then adds a `kernel.json` to the `data` directory where Jupyter searches for kernels:

```sh
pyenv virtualenv venv-test

pyenv activate venv-test
  pyenv-virtualenv: prompt changing will be removed from future release. configure `export PYENV_VIRTUALENV_DISABLE_PROMPT=1` to simulate the behavior.

jupyter kernelspec list
  Available kernels:
    python3    /Users/<USER_NAME>/.local/pipx/venvs/jupyterlab/share/jupyter/kernels/python3

# check this code: https://gist.github.com/lucasrla/c16f19290938ac02bab19f64298e2262
# in fact, no one should pipe curl to shell: https://0x46.net/thoughts/2019/04/27/piping-curl-to-shell/
sh -c "$(curl -L https://gist.githubusercontent.com/lucasrla/c16f19290938ac02bab19f64298e2262/raw/08c846bdd67b6c28ddbcb4b30a2b4f61a52fe393/pyenv-venv-register-jupyter-kernel.sh)"

jupyter kernelspec list
  Available kernels:
    venv-test    /Users/<USER_NAME>/Library/Jupyter/kernels/venv-test
    python3      /Users/<USER_NAME>/.local/pipx/venvs/jupyterlab/share/jupyter/kernels/python3
```

We can now run `jupyter notebook` (or `jupyter lab`) and verify that the new kernels are indeed available inside Jupyter. Open a new notebook, select a kernel, and run the following line:

```python
import sys; print(sys.executable); print(sys.version)
  /Users/<USER_NAME>/.pyenv/versions/venv-test/bin/python
  3.8.2 (default, Jun  2 2020, 18:18:45) 
  [Clang 11.0.3 (clang-1103.0.32.62)]
```

If we want to remove the `venv-test` kernel, simply do:

```sh
jupyter kernelspec remove venv-test
  Kernel specs to remove:
    venv-test           	/Users/<USER_NAME>/Library/Jupyter/kernels/venv-test
  Remove 1 kernel specs [y/N]: y
  [RemoveKernelSpec] Removed /Users/<USER_NAME>/Library/Jupyter/kernels/venv-test
```

If we want to uninstall `ipykernel` from the `venv-test` virtualenv, run:

```sh
pyenv activate venv-test

pip uninstall traitlets jupyter-client prompt-toolkit six tornado ipython-genutils decorator traitlets python-dateutil pyzmq jupyter-core wcwidth backcall pygments parso jedi ptyprocess pexpect pickleshare ipython appnope ipykernel

pyenv rehash

# or simply delete the pyenv-virtualenv and start from scratch
```


## Inspecting kernels across the filesystem

```sh
jupyter kernelspec list
  Available kernels:
    vips       /Users/<USER_NAME>/Library/Jupyter/kernels/vips
    python3    /Users/<USER_NAME>/.local/pipx/venvs/jupyterlab/share/jupyter/kernels/python3

tree -L 1 /Users/<USER_NAME>/.local/pipx/venvs/jupyterlab/share/jupyter/kernels/python3
  /Users/<USER_NAME>/.local/pipx/venvs/jupyterlab/share/jupyter/kernels/python3
  ├── kernel.json
  ├── logo-32x32.png
  └── logo-64x64.png

  0 directories, 3 files

cat /Users/<USER_NAME>/.local/pipx/venvs/jupyterlab/share/jupyter/kernels/python3/kernel.json
  {
  "argv": [
    "python",
    "-m",
    "ipykernel_launcher",
    "-f",
    "{connection_file}"
  ],
  "display_name": "Python 3",
  "language": "python"
  }
```

## Inspecting Jupyter packages

```sh
pyenv which pip
  /Users/<USER_NAME>/.pyenv/versions/3.8.2/bin/pip

pip list
  Package     Version
  ----------- --------
  argcomplete 1.11.1
  click       7.1.2
  pip         20.2.2
  pipx        0.15.4.0
  setuptools  41.2.0
  userpath    1.4.0

pipx runpip jupyterlab list
  Package             Version
  ------------------- ----------
  altair              4.1.0
  appnope             0.1.0
  async-generator     1.10
  attrs               19.3.0
  backcall            0.1.0
  beautifulsoup4      4.9.1
  bleach              3.1.5
  bokeh               2.0.2
  boto3               1.13.23
  botocore            1.16.23
  bqplot              0.12.12
  certifi             2020.4.5.1
  chardet             3.0.4
  decorator           4.4.2
  defusedxml          0.6.0
  docutils            0.15.2
  dynamodb-json       1.3
  entrypoints         0.3
  idna                2.9
  ipykernel           5.3.0
  ipython             7.15.0
  ipython-genutils    0.2.0
  ipywidgets          7.5.1
  jedi                0.17.0
  Jinja2              2.11.2
  jmespath            0.10.0
  json5               0.9.5
  jsonschema          3.2.0
  jupyter-client      6.1.3
  jupyter-core        4.6.3
  jupyter-server      0.1.1
  jupyterlab          2.1.4
  jupyterlab-pygments 0.1.1
  jupyterlab-server   1.1.5
  MarkupSafe          1.1.1
  mistune             0.8.4
  nbconvert           5.6.1
  nbformat            5.0.6
  notebook            6.0.3
  numpy               1.18.5
  packaging           20.4
  pandas              1.0.4
  pandocfilters       1.4.2
  parso               0.7.0
  pexpect             4.8.0
  pickleshare         0.7.5
  Pillow              7.1.2
  pip                 20.2.2
  prometheus-client   0.8.0
  prompt-toolkit      3.0.5
  ptyprocess          0.6.0
  Pygments            2.6.1
  pyparsing           2.4.7
  pyrsistent          0.16.0
  python-dateutil     2.8.1
  pytz                2020.1
  PyYAML              5.3.1
  pyzmq               19.0.1
  requests            2.23.0
  s3transfer          0.3.3
  Send2Trash          1.5.0
  setuptools          49.6.0
  simplejson          3.17.0
  six                 1.15.0
  soupsieve           2.0.1
  terminado           0.8.3
  testpath            0.4.4
  toolz               0.10.0
  tornado             6.0.4
  traitlets           4.3.3
  traittypes          0.2.1
  typing-extensions   3.7.4.2
  urllib3             1.25.9
  vega-datasets       0.8.0
  voila               0.1.21
  warcio              1.7.3
  wcwidth             0.2.2
  webencodings        0.5.1
  wheel               0.35.1
  widgetsnbextension  3.5.1
```