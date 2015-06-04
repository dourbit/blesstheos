alias nls='npm ls --depth=0 "$@" 2>/dev/null'
alias nls0=nls
alias nls1='npm ls --depth=1 "$@" 2>/dev/null' # sometimes I'd like to see 1 level deeper
alias nls-up='npm-check-updates'
alias nls-up-g='npm -g outdated --depth=0' # w/o --parseable | cut -d: -f3

# update / upgrade
alias npm-up-all='npm-check-updates -u && npm i' # locally
alias npm-up-g='npm update --global'
alias npm-ui='npm-check -u' # i for intearctive ui -- with or w/o -g
