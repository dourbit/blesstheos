alias ..='cd ..'
alias ...='cd .. ; cd ..'

alias please=sudo
alias df='df -h -x squashfs -x tmpfs -x devtmpfs'
alias grep='grep -i --color=auto' # case-insensitive
alias f='find . -iname'
alias ducks='du -cksh * | sort -rn|head -11' # file/dir sizes of the current dir
alias systail='tail -f /var/log/system.log'
alias less='less -R'
alias more='less -R' # less is more -- would it pick the -R from the less alias?

# Shows most used commands, cool script I got this from: http://lifehacker.com/software/how-to/turbocharge-your-terminal-274317.php
alias profileme="history | awk '{print \$2}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 20 | sort -nr"

uses aliases/apm.sh
uses aliases/npm.sh
uses aliases/pip.sh

uses aliases/clojure.sh
uses aliases/docker.sh

# NOTE: some aliases (e.g. git's) are sourced from elsewhere
# Also, there are system-dependent aliases in system.sh
# TODO: look into improving this - for `uses aliases.sh` becoming all there is
# Maybe add `aliases-all.sh` which sources all files, including `aliases.sh`?

# In general aliases aren't available for scripts to use
# although theres is: `shopt -s expand_aliases && uses aliases.sh`
# this isn't recommended - just add to use/helpers instead...
# and export whetever functions are necessary
