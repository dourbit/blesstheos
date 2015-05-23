# pip's upgrading of packages is unintuitive
# these are my aliases, a kind of cheatsheet

alias pip-iv="pip freeze | cut -d = -f 1 | xargs -n 1 pip search | grep -B2 'LATEST:'"
alias pip-uv="pip-review"
alias pip-u="sudo pip install --upgrade"
alias pip-ui="sudo pip-review --interactive"
alias pip-u-all="sudo pip-review --auto"
