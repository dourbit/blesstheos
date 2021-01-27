holy-time -r -l "use/platform/node.sh takes so long..." tell #slow!

if holy-time -r --silent holy on platform/node; then
  # source only if platform/node is on
  holy-dot src/nvm
  holy-time -r nvm-on

  # silently use ~/.nvmrc - the version maybe changed, though it's a luxury!
  holy-time -r --silent nvm use # why does it take so much time?

  # https://github.com/yarnpkg/yarn/issues/5353
  # after the nvm / npm global packages, which take precedence (from above)
  [ -x "$(command -v yarn)" ] && PATH-add "$(yarn global bin)"

  # aliases:
  if tis-true $HOLY_ALIASES; then
    # list installed packages
    alias nls='npm ls --depth=0 "$@" 2>/dev/null'
    alias nls0=nls
    alias nls1='npm ls --depth=1 "$@" 2>/dev/null' # sometimes I'd like to see 1 level deeper

    # list outdated packages (globally)
    alias nls-up='npm -g outdated --depth=0' # w/o --parseable | cut -d: -f3
    alias nls-up-a='ncu' # npm-check-updates

    # upgrade npm + all global packages
    alias npm-up='npm-check -g -u' # using interactive ui
    alias npm-up-all='nvm install-latest-npm && npm-check -g -y' # just do it all

    # update / upgrade a local project
    alias npm-up-a='ncu -u && yarn install' # upgrade all of a project's packages
    alias npm-up-i='npm-check -u' # i for intearctive ui + run yarn install later
  fi

fi
