# https://github.com/rbenv/rbenv

# enable shims and autocompletion using .bash_profile
# if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# use the following, instead of ~/.rbenv
# export RBENV_ROOT=/usr/local/var/rbenv

if silent holy on platform/ruby; then

  if tis-true $HOLY_ALIASES; then
    alias bex="bundle exec"
  fi

fi
