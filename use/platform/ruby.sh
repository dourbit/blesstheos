# https://github.com/rbenv/rbenv

# TODO: research if and when wanting to:
# use the following, instead of ~/.rbenv
# export RBENV_ROOT=/usr/local/var/rbenv

if silent holy on platform/ruby; then

  if [ -d "$HOME/.rbenv" ]; then
    # TODO: do these need to go in front of $PATH (as before)?
    # there is a mismatch right now between which ruby which rbenv used
    # when both installed, which is in part an install issue
    PATH-add "$HOME/.rbenv/bin"
    PATH-add "$HOME/.rbenv/plugins/ruby-build/bin"
    # export PATH="$HOME/.rbenv/bin:$PATH"
    # export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

    # NOTE: calling it repeatedly keeps on adding the shims to $PATH
    # enable shims and autocompletion using .bash_profile
    # if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
  fi

  if tis-true $HOLY_ALIASES; then
    alias bex="bundle exec"
  fi

fi
