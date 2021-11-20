#!/usr/bin/env bash

dotfiles_dir="$(dirname "$(dirname "$(readlink -f "$0")")")"
os=$(bash "$dotfiles_dir/utils/get-platform")

source "$dotfiles_dir/utils/install-pkg.sh"

# MacOS is usually a version or two behind, Ubuntu LTS several
install-pkg python3

# Never understood why Ubuntu doesn't bundle this
# on desktop at least
if [ "$os" =~ "ubuntu" ]; then
  install-pkg python3-pip
  install-pkg python3-dev
fi

python3 -m pip install --upgrade pip
python3 -m pip install --user setuptools
python3 -m pip install --user virtualenv
python3 -m pip install --user pipenv
python3 -m pip install --user psycopg2-binary
python3 -m pip install --user mypy
python3 -m pip install --user pylint
