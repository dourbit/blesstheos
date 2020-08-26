# system /terminal-specific stuff

# export ARCHFLAGS="-arch i386 -arch x86_64"
# Because python compiles for the wrong architecture!
# Is this a problem for Linux?
export ARCHFLAGS="-arch x86_64"

if onLinux; then
  export EDITOR='vim'
  [ -f /etc/bash_completion ] && . /etc/bash_completion
  alias du='du -k --max-depth=1'
elif onMac; then
  export EDITOR='mate -w'
  [ -f /opt/local/etc/bash_completion ] && . /opt/local/etc/bash_completion
  alias du='du -k -d1'
  alias top='top -o cpu'
  alias vi='mate'
else
  echo "Unexpected system: $HOLY_KERNEL"
fi

if [ "$TERM" != "dumb" ]; then
  # color depends on terminal not being "dumb"
  if onLinux; then
    color_option='--color=auto'
  else
    color_option='-G'
  fi
  # . ~/.bash/jump.sh # is this only for non-dumb terminal?
else
  color_option=''
  # NOTE: this was PATH=opt/local/bin:$PATH
  # maybe add_to_PATH_front later if needed
  # ls /opt/local/bin # No such file or directory
fi

alias l="ls -CF $color_option"
alias ls="ls $color_option"
alias la="ls -A $color_option"
alias ll="ls -halF $color_option"
