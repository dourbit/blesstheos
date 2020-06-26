# dotfiles

`git clone git@github.com:orlin/dots.git ~/.dots`

Change `.dots` to where you want it cloned. It must be relative to `$HOME`,
though in the future perhaps absolute paths could be supported too.

Copy & modify any / all files that you need from `~/.dots/home` to `~`.
These must be under the home directory. This is just for `.gitconfig`,
as that contains my own user info.

Append to your bash configs, by copy-pasting the following code blocks:

> ~/.bash_profile

```bash
touch  ~/.bash_profile
tee -a ~/.bash_profile > /dev/null << 'END'

# source ~/.bashrc
[ -f ~/.bashrc ] && . ~/.bashrc

# code you don't want to run each time .bashrc is sourced
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
END
```

> ~/.bashrc

```bash
touch  ~/.bashrc
tee -a ~/.bashrc > /dev/null << 'END'

export HOME_DOTS=".dots"
export BREW_ON=true # omit to decrease / skip Homebrew usage

[ -f ~/.bashrc-pre ] && . "$HOME"/.bashrc-pre
. "$HOME/$HOME_DOTS"/source.sh
END
. ~/.bashrc
```

Nothing would really happen unless you run some of the
[install scripts](https://github.com/orlin/dots/tree/master/install).
Many installs depend on other installs.
Run `install/_all` for everything, or look at the code
for example order or comments.

Packages are for the time being all installed manually.

Atom restores to its configured state through a [sync-settings](http://atom.io/packages/sync-settings) package given the [id of a gist, such as this one](https://gist.github.com/orlin/0a47688f152d7ceccb646a23e8245449) and a GitHub Personal Access Token that can read & write to it.
Manual backup can be done with `sync-settings:backup` through the [Command Palette](https://github.com/atom/command-palette).

## License

[MIT](http://orlin.mit-license.org)
