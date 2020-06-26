# dotfiles

`git clone git@github.com:orlin/dots.git ~/.dots`

This approach covers both login and non-login shells -- so far just for `bash`.
Change `.dots` to wherever `dots` is cloned. It has to be relative to `$HOME`,
though in the future perhaps absolute paths could be supported as well.

Copy & modify any / all files that you need from `~/.dots/home` to `~`.
These must be under the home directory.

Append to the shell configs, by copy-pasting the following code blocks:

> ~/.bash_profile

```bash
tee -a ~/.bash_profile > /dev/null << 'END'

# source ~/.bashrc
[ -f ~/.bashrc ] && . ~/.bashrc

# code you don't want to run each time .bashrc is sourced
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
END
```

> ~/.bashrc

```bash
tee -a ~/.bashrc > /dev/null << 'END'

export HOME_DOTS=".dots"
export DOTS_PATH="$HOME/$HOME_DOTS"
export BREW_ON=true # omit to reduce or skip Homebrew usage

source "$HOME/.bashrc-pre"
source "$DOTS_PATH/source.sh"
END
```

Run any `install` scripts after sourcing the above or with a new shell.
A changed prompt would be a good indicator / confirmation to begin with.
It's a good idea to run any sudo command before running scripts that need sudo,
e.g. `sudo ls` so that the password prompt does not trip-up the install.
I basically start a new shell after each step to confirm it was successful.
Sometimes installs depend on other installs, here is an example order:

1. `atops` - needed for many of the install scripts, find the MacOS equivalents...
2. `brew` - [Homebrew](https://brew.sh/) usage depends on `export BREW_ON=true`; MacOS TODO...
3. `shell` - scripting with `bash` + `bb` or `closh`; `brewOn` is applicable if wanted for `bb`
4. `java` - unless Ubuntu / Debian: [download & install AdoptOpenJDK](https://adoptopenjdk.net/releases.html?variant=openjdk11&jvmVariant=hotspot) manually...
5. `clojure` - depends on `java`, with `brewOn` possibly for some installs
6. `node` - MacOS version has worked in the past, though not tested lately...
7. `ruby` - via `brew` on a Mac - maybe unify for all to be brew-based...
8. `term` - it's just for Linux, almost...
9. `editor` - mostly fully `apt install`
10. `ubuntu-docker` and certain `docker/` containers
11. `apt-python`
12. `apt-desktop`

Packages are for the time being all installed manually.

Atom restores to its configured state through a [sync-settings](http://atom.io/packages/sync-settings) package given the [id of a gist, such as this one](https://gist.github.com/orlin/0a47688f152d7ceccb646a23e8245449) and a GitHub Personal Access Token that can read & write to it. Remember to run `sync-settings:backup` through the [Command Palette](https://github.com/atom/command-palette) once in a while and especially after restore / upgrade / changes so that things stay relatively up-to-date for further reuse.

## License

[MIT](http://orlin.mit-license.org)
