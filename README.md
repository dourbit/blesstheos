# dotfiles

`git clone git@github.com:orlin/dots.git ~/.dots`

This approach covers both login and non-login shells -- so far just for `bash`.
Change `.dots` to wherever `dots` is cloned.  It has to be relative to `$HOME`,
though in the future perhaps absolute paths could be supported as well.

Copy & modify any / all files that you need from `~/.dots/home` to `~`.
These must be under the home directory.

Touch and edit the following files:

> ~/.bash_profile

```bash
# source ~/.bashrc
[ -f ~/.bashrc ] && . ~/.bashrc

# code you don't want to run each time .bashrc is sourced
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
```

> ~/.bashrc # append to the bottom end

```bash
export HOME_DOTS=".dots"
export DOTS_PATH="~/$HOME_DOTS"
. ~/.dots/source.sh

# for android development - one would also need to install java ...
export ANDROID_HOME=$HOME/.dots/android/sdk # if installed here ...
add_to_PATH $ANDROID_HOME/platform-tools
add_to_PATH $ANDROID_HOME/tools
```

The bash-specific stuff should be contained in `use/bash.sh`.
Though I have not tried using any of this with other shells.
Try `.profile` instead?

Run any `install` scripts after sourcing the above or with a new shell.
A changed prompt would be a good indicator / confirmation to begin with.
It's a good idea to run any sudo command before running scripts that need sudo,
e.g. `sudo ls` so that the password prompt does not trip-up the install.
I basically start a new shell after each step to confirm it was successful.
Sometimes installs depend on other installs, here is an example order:

1. `atops` - generally needed for many of the install scripts to run
2. `brew` - [Homebrew](https://brew.sh/) runs on both Mac and Linux
3. `ruby` - via `brew` on a Mac - maybe unify for all to be brew-based...
4. `node`
5. `linux-java` / [AdoptOpenJDK](https://adoptopenjdk.net/)
6. `clojure` - depends on `java` and `brew`
7. `linux-docker` and certain `docker/` containers
8. `linux-python`
9. `linux-desktop`

Packages are for the time being all installed manually.

Atom restores to its configured state through a [sync-settings](http://atom.io/packages/sync-settings) package given the [id of a gist, such as this one](https://gist.github.com/orlin/0a47688f152d7ceccb646a23e8245449) and a GitHub Personal Access Token that can read & write to it.  Remember to run `sync-settings:backup` through the [Command Palette](https://github.com/atom/command-palette) once in a while and especially after restore / upgrade / changes so that things stay relatively up-to-date for further reuse.

## License

[MIT](http://orlin.mit-license.org)
