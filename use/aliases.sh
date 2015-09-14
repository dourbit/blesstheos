alias ..='cd ..'
alias ...='cd .. ; cd ..'

alias please=sudo
alias f='find . -iname'
alias ducks='du -cksh * | sort -rn|head -11' # file/dir sizes of the current dir
alias systail='tail -f /var/log/system.log'
alias less='less -R'
alias more='less -R' # less is more -- would it pick the -R from the less alias?
alias df='df -h'

# Shows most used commands, cool script I got this from: http://lifehacker.com/software/how-to/turbocharge-your-terminal-274317.php
alias profileme="history | awk '{print \$2}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 20 | sort -nr"

# some aliases depend on variables being set
# e.g. export TRANSMISSION_RE='127.0.0.1:9091 --auth user:pw'
[[ -n "$TRANSMISSION_RE" ]] && alias transmission-remote="transmission-remote ${TRANSMISSION_RE}"

uses aliases/apm.sh
uses aliases/npm.sh
uses aliases/pip.sh

# NOTE: some aliases (e.g. git's) are sourced from elsewhere
# also, there are system-dependent aliases in system.sh

# In general aliases aren't available for scripts to use
# although theres is: shopt -s expand_aliases
# this isn't recommended - just use functions.sh instead...
# and export whetever functions are necessary
