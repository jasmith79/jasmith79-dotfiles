# dotfile, a.k.a. Not Your Grandfather's Dotfiles

**NOTE**: using this can potentially add a lot of stuff to your computer. Use at your own risk. It's also still at least right at this moment very much a WIP.

## **EXTRA NOTE FOR MAC USERS**

All of the macos-specific stuff assumes intel mac. For that matter, all the general stuff assumes intel (Linux on ARM is at least for now a little esoteric). I will be updating for the ARM-based machines soon (planning to buy one this summer) but for right now it will almost certainly fail hard on e.g. an M1.

## Usage

Clone the repo to your home directory:

```shell
cd ~ && git clone https://github.com/jasmith79/jasmith79-dotfiles.git dotfiles
cd dotfiles
```

At this point you can run `dotfile -h` for help or if you just want everything:

```shell
dotfile install -a --exclude git
```

You can leave the git install script in if you really want, but it may set your git username and email to mine ;-)

* Go out for coffee. Or something stronger, hell, I'm not judging. But it's going to take awhile.
* RTFO 🤘

### NOTE TO SELF on Linux

* Finish dropbox setup in the open browser window.
* Sign in to google account
* Open google calendar to allow notifications
* Set up ssh keys
* Verify install with testcheck.sh
* Add nitrogen --restore to start up applications in de/wm if using e.g. cinnamon
