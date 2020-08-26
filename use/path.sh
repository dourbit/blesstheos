PATH-add  /usr/local/sbin # TODO: move it to my personal dots
PATH-add ${HOLY_HOME}/bin

# TODO: add-PATH (for the rest of these paths)?

PATH-add .
mkdir -p ~/bin # TODO: move to init/ - bottom of once.sh
PATH-add ~/bin
# TODO: move to init/ - bottom of once.sh
[ ! -e ~/.bin ] && ln -s ~/bin ~/.bin # .bin symlink to bin for b-compatibility
PATH-add ~/deps/bin # see install/shell

export PATH # concludes what the PATH will be
