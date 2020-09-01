# python-on-macos

The ultimate Python setup for macOS Catalina. 

Isolated and reproducible environments that are easy to use. 

Built with `pyenv`, `virtualenv`, `poetry`, `jupyter`, `pipx`, and `conda` (all of them, carefully integrated).

Online at: https://lucasrla.github.io/python-on-macos/


## Local development with jekyll

```sh
# https://lucasrla.github.io/macos-setup/ruby/jekyll.html#taking-advantage-of-ruby-version
# to make sure this project is fully reproducible
echo "ruby-2.7.1" > .ruby-version

# https://lucasrla.github.io/macos-setup/ruby/bundler.html#configuring-bundler-to-have-isolated-environments-by-project
# check out my bundler setup
bundle install

bundle exec jekyll serve
```