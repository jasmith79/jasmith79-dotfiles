#!/usr/bin/env bash
# Installs clojure, lein

dotfiles_dir="$(dirname "$(dirname "$(readlink -f "$0")")")"

os="$(bash $dotfiles_dir/utils/get-platform)"
source "$dotfiles_dir/utils/install-pkg.sh"
source "$dotfiles_dir/utils/pushpop.sh"

if ! command -v javac >/dev/null; then
  source "$dotfiles_dir/installers/java.sh"
fi

install-pkg rlwrap

pushd /tmp || exit 1

if ! command -v clj >/dev/null; then
  if [ "$os" = "macos" ]; then
    # TODO, add tooling to linux install
    install-pkg clojure/tools/clojure
    install-pkg planck # nodejs cljs repl
    install-pkg nbb    # babashka, but for node cljs scripts
    install-pkg borkdude/brew/babashka
    install-pkg borkdude/brew/clj-kondo
  elif [[ "$os" =~ "ubuntu" ]]; then
    curl -O https://download.clojure.org/install/linux-install-1.10.3.1029.sh
    chmod +x linux-install-1.10.3.1029.sh
    sudo bash linux-install-1.10.3.1029.sh
  elif [ "$os" = "arch" ]; then
    echo "Not implemented yet!" >&2
    exit 1
  else
    echo "Unsupported platform $os!" >&2
    exit 1
  fi
fi

if ! command -v lein >/dev/null; then
  curl -O 'https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein'
  sudo chmod a+x lein
  sudo mv lein /usr/local/bin
fi

popd || exit 1
