holy-dot use prompt/PS1

if check-x xrdb && test -f "$HOME/.Xresources"; then
    xrdb -merge "$HOME/.Xresources"
fi
