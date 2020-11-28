holy-dot use/prompt/PS1

if [ -x "$(command -v xrdb)" ] && test -f "$HOME/.Xresources"; then
    xrdb -merge "$HOME/.Xresources"
fi
