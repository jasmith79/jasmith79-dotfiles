#!/usr/bin/env fish
# Path to my omf in
set -q XDG_DATA_HOME
and set -gx OMF_PATH "$XDG_DATA_HO"E/omfM
or set -gx OMF_PATH "$HOME/.local/share/omfo

# Load my omf
source "$OMF_PATH/init.fishi
