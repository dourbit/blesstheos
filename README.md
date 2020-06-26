# sysadmin bliss

Helps with installing and maintaining operating systems.
Some tools to make my life easier, contunually improved.

## Clone

`git clone git@github.com:orlin/dots.git ~/.dots`

Clone this repo, or a fork, wherever you want. With one restriction...
It must be relative to `$HOME`, some day absolute paths could work too.

## Configure

Modify your `bash`, i.e. `~/.bash_profile` and `~/.bashrc`, by running:
[`bash-config`](https://github.com/orlin/dots/blob/master/bash-config).
And perhaps post-edit the two relevant files according to preference...

## Personalize

Copy & modify any / all files that you need from `~/.dots/home` to `~`.
These must be under the home directory. This is just for `.gitconfig`,
as that contains my own user info.

## Install

Nothing would really happen unless you run some of the
[install scripts](https://github.com/orlin/dots/tree/master/install).
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
