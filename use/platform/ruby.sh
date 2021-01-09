# https://github.com/rbenv/rbenv

# enable shims and autocompletion using .bash_profile
# if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# use the following, instead of ~/.rbenv
# export RBENV_ROOT=/usr/local/var/rbenv

if silent holy on platform/ruby; then

  if [ -d "$HOME/.rbenv" ]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
    eval "$(rbenv init -)"
  fi

  if tis-true $HOLY_ALIASES; then
    alias bex="bundle exec"
  fi

fi
