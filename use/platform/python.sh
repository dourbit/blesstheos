holy-dot src/install

if holy-be-on platform/python; then

  # pip's upgrading of packages is unintuitive
  # these are my aliases, a kind of cheatsheet
  alias pip=pip3
  alias pip-iv="pip3 freeze | cut -d = -f 1 | xargs -n 1 pip3 search | grep -B2 'LATEST:'"
  alias pip-uv="pip-review"
  alias pip-ui="sudo pip-review --interactive"
  alias pip-up="sudo pip3 install --upgrade"
  alias pip-up-all="sudo pip-review --auto"

  [ -n "$BASH" ] && alias fuck='eval $(thefuck $(fc -ln -1)); history -r'

fi
