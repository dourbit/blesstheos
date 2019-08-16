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

> ~/.bashrc

```bash
HOME_DOTS=".dots"
. ~/.dots/source.sh

# for android development
export ANDROID_HOME=$HOME/.dots/android/sdk # if installed here
add_to_PATH $ANDROID_HOME/platform-tools
add_to_PATH $ANDROID_HOME/tools
```

For Java on Linux, install `openjdk-8-jdk` and add the following to your shell exports (before sourcing `.dots`).

```bash
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
```

The bash-specific stuff should be contained in `use/bash.sh`.
Though I have not tried using any of this with other shells.
Try `.profile` instead?

## License

[MIT](http://orlin.mit-license.org)
