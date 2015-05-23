# pip's upgrading of packages is unintuitive
# these are my aliases, a kind of cheatsheet

alias pip-iv="pip freeze | cut -d = -f 1 | xargs -n 1 pip search | grep -B2 'LATEST:'"
alias pip-uv="pip-review"
alias pip-up="sudo pip install --upgrade"
alias pip-ui="sudo pip-review --interactive"
alias pip-up-all="sudo pip-review --auto"


# some pip-installed scripts are easier to use with aliases

[ -n "$BASH" ] && alias fuck='eval $(thefuck $(fc -ln -1)); history -r'
