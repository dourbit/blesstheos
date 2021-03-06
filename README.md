# holy init #bless the os

Helps with installing and maintaining operating systems.
Some tools to make my life easier, contunually improved.

## Clone

Clone this repo, or a fork, to anywhere you want, and then cd into it.

```sh
git clone git@github.com:dourbit/blesstheos.git ~/.holy && cd ~/.holy
```

## Configure

Setup your shell by running:

```sh
holy init && . ~/$(holy rc)
```

It will configure `$SHELL`, or you can request a specific one,
though only `bash` is available so far...

Perhaps post-edit the affected files according to preference -
for `bash` that would be `~/.bashrc` and `~/.bash_profile`.

## Personalize

Edit any of my `home/` files before or after they get copied to `$HOME`.
So far nothing has been installed yet, nor copied either.
For example the `.gitconfig` contains my own user info.
An easy way is to setup your own files first, all those found in `home/`, etc.
Any files that already exist will stay unmodified.
Have them in place before continuing with install that's next.

You may also want to edit what the "configure" step above has
added to your `bash` configuration files - `~/.bash_profile` and `~/.bashrc`.

## Install

Nothing would really happen unless you run some of the
[install scripts](https://github.com/dourbit/blesstheos/tree/master/install).
Many installs depend on other installs.
Run `install/_all` for everything, or look at the code
for example order or comments.

### Packages

Packages are for the time being all installed manually...

### Atom Sync

Atom restores to its configured state through a [sync-settings](http://atom.io/packages/sync-settings) package given the [id of a gist, such as this one](https://gist.github.com/orlin/0a47688f152d7ceccb646a23e8245449) and a GitHub Personal Access Token that can read & write to it.
Manual backup can be done with `sync-settings:backup` through the [Command Palette](https://github.com/atom/command-palette).

## License

[MIT](http://orlin.mit-license.org)
