# jasmith79-dotfiles
My dotfiles repo. Has files for neovim, bash, etc. Clone to the user directory and run the `install.sh` script from inside the jasmith79-dotfiles directory to install (may need to add the +x flag). On linux to configure terminology using the mouse-driven menus, I can't for the life of me figure out what encoding their config file uses (it certainly isn't ASCII or UTF-8).

* Open neovim and type :UpdateRemotePlugins register deoplete
* If on linux change the terminal launcher to use terminology: terminology --font='NotoMono-Regular'
* Also to make terminology more fun turn off auditory bell, set keybindings
  1. ctrl-alt-s       hozizontal split
  2. ctrl-alt-v       vertical split
  3. alt-shift-t      change window title
  4. ctrl-backspace   kill focused pane/tab/window
* RTFO 🤘

## Fresh install checklist

### Linux

* Change terminal launcher icon to use terminology
* Run dropbox setup
* Sign in to google account
* Open google calendar to allow notifications
* Run hangups setup
* Set up ssh keys
* Verify install with testcheck.sh
* Add music to cmus
* Add nitrogen --restore to start up applications in de/wm if using e.g. cinnamon
