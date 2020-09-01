---
title: miniconda
parent: conda
nav_order: 1
---

# miniconda
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

If you don't know what Conda is, here's [an overview](https://www.anaconda.com/blog/understanding-conda-and-pip):

> Conda is a cross-platform package and environment manager that installs and manages conda packages. Conda packages are binaries. There is never a need to have compilers available to install them. Additionally conda packages are not limited to Python software. They may also contain C or C++ libraries, R packages or any other software.
>
> Pip installs Python packages, whereas conda installs packages which may contain software written in any language.

There are different flavors of Conda. The main ones are anaconda and miniconda. We have chosen miniconda and this [StackOverflow answer summarizes well](https://stackoverflow.com/questions/45421163/anaconda-vs-miniconda#45421527) why we chose it:

> Choose Miniconda if you
> 
> - Do not mind installing each of the packages you want to use individually
> - Do not have time or disk space to install over 150 packages at once, and/or
> - Just want fast access to Python and the conda commands, and wish to sort out the other programs later

## Install miniconda via pyenv

<div class="warning-box">Before installing miniconda you must install and configure pyenv first. <a href="pyenv/pyenv.html">Read the setup instructions here</a>.</div>

pyenv makes installing miniconda nice and easy. 

Well, almost. There is one trick that we still need to pull off in advance:

```conf
# create a `~/.condarc` file 
# and add the following content to it:
auto_update_conda: False
```

This line is to prevent conda to auto-updating itself automatically during the installation process. If we don't set this flag to false, conda would have jumped from `4.7.12` to `4.8.3` without even asking. There is an pull request to prevent that behavior ([#997](https://github.com/pyenv/pyenv/pull/997)) that has been open for years now.

```sh
cat ~/.condarc
  auto_update_conda: false
```

With that set, let's install the latest version of miniconda available via pyenv:

```
# find the latest miniconda version
pyenv install --list
  [...]

pyenv install miniconda3-4.7.12
  [...]
  Installing Miniconda3-4.7.12-MacOSX-x86_64...
  Collecting package metadata (current_repodata.json): done
  Solving environment: done

  ==> WARNING: A newer version of conda exists. <==
    current version: 4.7.12
    latest version: 4.8.3

  Please update conda by running

      $ conda update -n base -c defaults conda

  ## Package Plan ##

    environment location: /Users/<USER_NAME>/.pyenv/versions/miniconda3-4.7.12

    added / updated specs:
      - pip

  The following packages will be downloaded:

      package                    |            build
      ---------------------------|-----------------
      ca-certificates-2020.1.1   |                0         125 KB
      certifi-2020.4.5.1         |           py37_0         155 KB
      openssl-1.1.1g             |       h1de35cc_0         2.2 MB
      pip-20.0.2                 |           py37_3         1.7 MB
      ------------------------------------------------------------
                                            Total:         4.2 MB

  The following packages will be UPDATED:

    ca-certificates                               2019.8.28-0 --> 2020.1.1-0
    certifi                                  2019.9.11-py37_0 --> 2020.4.5.1-py37_0
    openssl                                 1.1.1d-h1de35cc_2 --> 1.1.1g-h1de35cc_0
    pip                                         19.2.3-py37_0 --> 20.0.2-py37_3

  Downloading and Extracting Packages
  [...]
  Preparing transaction: done
  Verifying transaction: done
  Executing transaction: done
  Installed Miniconda3-4.7.12-MacOSX-x86_64 to /Users/<USER_NAME>/.pyenv/versions/miniconda3-4.7.12
```

Now, check if it is working:

```
which conda
  /Users/<USER_NAME>/.pyenv/shims/conda

pyenv which conda
  /Users/<USER_NAME>/.pyenv/versions/miniconda3-4.7.12/bin/conda

conda --version
  pyenv: conda: command not found

  The `conda` command exists in these Python versions:
    miniconda3-4.7.12

  Note: See 'pyenv help global' for tips on allowing both
        python2 and python3 to be found.
```

Well, it has been installed but it isn't exactly working. 

Let's work around that:

```sh
mkdir conda-test
cd conda-test

# set miniconda as the python version in the `conda-test` dir
pyenv local miniconda3-4.7.12

# voila!
conda --version
  conda 4.7.12

conda info
     active environment : base
    active env location : /Users/<USER_NAME>/.pyenv/versions/miniconda3-4.7.12
            shell level : 0
       user config file : /Users/<USER_NAME>/.condarc
 populated config files : /Users/<USER_NAME>/.condarc
          conda version : 4.7.12
    conda-build version : not installed
         python version : 3.7.4.final.0
       virtual packages :
       base environment : /Users/<USER_NAME>/.pyenv/versions/miniconda3-4.7.12  (writable)
           channel URLs : https://repo.anaconda.com/pkgs/main/osx-64
                          https://repo.anaconda.com/pkgs/main/noarch
                          https://repo.anaconda.com/pkgs/r/osx-64
                          https://repo.anaconda.com/pkgs/r/noarch
          package cache : /Users/<USER_NAME>/.pyenv/versions/miniconda3-4.7.12/pkgs
                          /Users/<USER_NAME>/.conda/pkgs
       envs directories : /Users/<USER_NAME>/.pyenv/versions/miniconda3-4.7.12/envs
                          /Users/<USER_NAME>/.conda/envs
               platform : osx-64
             user-agent : conda/4.7.12 requests/2.22.0 CPython/3.7.4 Darwin/19.5.0 OSX/10.15.5
                UID:GID : 501:20
             netrc file : None
           offline mode : False
```

## Configure conda

First, install an experimental feature that improves `conda` interoperability with `pip`: 

```sh
conda config --set pip_interop_enabled True
```

For more details about it, read [the docs](https://docs.conda.io/projects/conda/en/latest/user-guide/configuration/pip-interoperability.html).

Next, add two channels to our conda setup: `conda-forge` ([website](https://conda-forge.org)) and `bioconda` ([website](https://bioconda.github.io)). If you don't know what a conda channel is, read [the docs](https://docs.conda.io/projects/conda/en/latest/user-guide/concepts/channels.html).

```sh
conda config --add channels defaults
  Warning: 'defaults' already in 'channels' list, moving to the top

conda config --add channels bioconda

conda config --add channels conda-forge

conda config --show-sources
  ==> /Users/<USER_NAME>/.condarc <==
  auto_update_conda: False
  pip_interop_enabled: True
  channels:
    - conda-forge
    - bioconda
    - defaults
```

Please notice the specific order we used, it is important. We want `conda-forge` to have the highest priority (that's why it is the last to be added).

Let's check our `~/.condarc` config file now:

```sh
cat ~/.condarc
  auto_update_conda: false
  pip_interop_enabled: true
  channels:
    - conda-forge
    - bioconda
    - defaults
```

Let's install Python by default with every new conda environment:

```sh
conda config --add create_default_packages python

conda config --show-sources
  ==> /Users/<USER_NAME>/.condarc <==
  auto_update_conda: False
  auto_activate_base: False
  create_default_packages:
    - python
  pip_interop_enabled: True
  channels:
    - conda-forge
    - bioconda
    - defaults
```

Please do not skip this setting! Having a Python interpreter installed in a conda environment is crucial for `pyenv-virtualenv` to recognize it.

There are two other useful commands for understanding what is under the hood:

- `conda config --show` prints out all current configuration values (it's a long list!)
- `conda config --describe` provides detailed explanation for each configuration option

For more information, read [the docs](https://docs.conda.io/projects/conda/en/latest/user-guide/configuration/use-condarc.html).


## Avoid bloating the base environment up

```sh
conda env list
# conda environments:
#
base                  *  /Users/<USER_NAME>/.pyenv/versions/miniconda3-4.7.12
```

Ideally, we'd also want to prevent usage of the conda's `base` environment as much as possible. Avoiding `base` means installing unnecessary stuff there and reducing the chances of bloating it up. So, use dedicated conda environments for your projects.

Unfortunately (as of `2020-06-02`), it seems there is no sane way to block package installations to the `base` environment. See [this StackOverflow thread](https://stackoverflow.com/questions/51577258/block-package-installations-to-conda-base-environment). It would be great to have an equivalent of `PIP_REQUIRE_VIRTUALENV` ([docs](https://docs.python-guide.org/dev/pip-virtualenv/#requiring-an-active-virtual-environment-for-pip)) in conda.

If there is no active conda environment, `conda install` will install packages on `base`, even if `auto_activate_base` is set to `false`:

```sh
conda config --set auto_activate_base false

conda config --show-sources
==> /Users/<USER_NAME>/.condarc <==
auto_update_conda: False
auto_activate_base: False
pip_interop_enabled: True
channels:
  - conda-forge
  - bioconda
  - defaults

conda info
     active environment : None
     [...]

conda install numpy
  [...]
  ## Package Plan ##

    environment location: /Users/<USER_NAME>/.pyenv/versions/miniconda3-4.7.12

    added / updated specs:
      - numpy
```

Crazy!


## Inspecting pyenv's shims after miniconda installation

FYI, conda is kind of expansive – and even the "mini" version still installs lots of binaries.

The folks from pyenv have devised ways to keep the "shims hell" a bit more under control. See ([#1085](https://github.com/pyenv/pyenv/issues/1085)). 

Still, take a look at how many shims pyenv creates:

```sh
# BEFORE installing miniconda3-4.7.12
tree ~/.pyenv/shims
  /Users/<USER_NAME>/.pyenv/shims
  ├── 2to3
  ├── 2to3-3.8
  ├── easy_install
  ├── easy_install-2.7
  ├── easy_install-3.8
  ├── idle
  ├── idle3
  ├── idle3.8
  ├── pip
  ├── pip2
  ├── pip2.7
  ├── pip3
  ├── pip3.8
  ├── pydoc
  ├── pydoc3
  ├── pydoc3.8
  ├── python
  ├── python-config
  ├── python2
  ├── python2-config
  ├── python2.7
  ├── python2.7-config
  ├── python2.7-gdb.py
  ├── python3
  ├── python3-config
  ├── python3.8
  ├── python3.8-config
  ├── python3.8-gdb.py
  └── smtpd.py

  0 directories, 29 files

# AFTER installing miniconda3-4.7.12
tree ~/.pyenv/shims
  /Users/<USER_NAME>/.pyenv/shims
  ├── 2to3
  ├── 2to3-3.7
  ├── 2to3-3.8
  ├── activate
  ├── c_rehash
  ├── captoinfo
  ├── chardetect
  ├── conda
  ├── conda-env
  ├── cph
  ├── deactivate
  ├── easy_install
  ├── easy_install-2.7
  ├── easy_install-3.8
  ├── idle
  ├── idle3
  ├── idle3.7
  ├── idle3.8
  ├── infotocap
  ├── lzcat
  ├── lzcmp
  ├── lzdiff
  ├── lzegrep
  ├── lzfgrep
  ├── lzgrep
  ├── lzless
  ├── lzma
  ├── lzmadec
  ├── lzmainfo
  ├── lzmore
  ├── ncursesw6-config
  ├── pip
  ├── pip2
  ├── pip2.7
  ├── pip3
  ├── pip3.8
  ├── pydoc
  ├── pydoc3
  ├── pydoc3.7
  ├── pydoc3.8
  ├── python
  ├── python-config
  ├── python.app
  ├── python2
  ├── python2-config
  ├── python2.7
  ├── python2.7-config
  ├── python2.7-gdb.py
  ├── python3
  ├── python3-config
  ├── python3.7
  ├── python3.7-config
  ├── python3.7m
  ├── python3.7m-config
  ├── python3.8
  ├── python3.8-config
  ├── python3.8-gdb.py
  ├── pythonw
  ├── pyvenv
  ├── pyvenv-3.7
  ├── smtpd.py
  ├── sqlite3_analyzer
  ├── tabs
  ├── tclsh
  ├── tclsh8.6
  ├── tic
  ├── toe
  ├── tqdm
  ├── tset
  ├── unlzma
  ├── wheel
  ├── wish
  ├── wish8.6
  ├── xzcmp
  └── xzdec

  0 directories, 75 files  
```
