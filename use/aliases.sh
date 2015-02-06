alias ..='cd ..'
alias ...='cd .. ; cd ..'

alias please=sudo
alias f='find . -iname'
alias ducks='du -cksh * | sort -rn|head -11' # file/dir sizes of the current dir
alias systail='tail -f /var/log/system.log'
alias less='less -R'
alias m='less -R' # less is more -- would it pick the -R from the less alias?
alias df='df -h'

# Shows most used commands, cool script I got this from: http://lifehacker.com/software/how-to/turbocharge-your-terminal-274317.php
alias profileme="history | awk '{print \$2}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 20 | sort -nr"
