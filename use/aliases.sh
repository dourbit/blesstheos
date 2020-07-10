# NOTE: In general aliases aren't available for scripts to use,
# though there is: `shopt -s expand_aliases && uses aliases.sh`...

for src in "${HOLY_HOME}/use/aliases"/*; do . "$src"; done

alias ..='cd ..'
alias ...='cd .. ; cd ..'

alias type='type -a'
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
