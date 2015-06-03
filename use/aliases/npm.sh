alias nls='npm ls --depth=0 "$@" 2>/dev/null'
alias nls0=nls
alias nls1='npm ls --depth=1 "$@" 2>/dev/null' # sometimes I'd like to see 1 level deeper
alias nls-up='npm-check-updates'
alias npm-up-all='npm-check-updates -u && npm i' # update / upgrade
