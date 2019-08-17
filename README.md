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

1. `shell`
2. [Homebrew](https://brew.sh/) - for Mac, or `linux-brew` after improvements...
3. `ruby` - via `brew` on a Mac
4. `node`
5. `linux-java` / [AdoptOpenJDK](https://adoptopenjdk.net/)
6. `clojure` - depends on `java`, also `brew` for Mac install

Packages are for the time being all installed manually.


## License

[MIT](http://orlin.mit-license.org)
