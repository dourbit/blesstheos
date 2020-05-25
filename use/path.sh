add_to_PATH  /usr/local/sbin
add_to_PATH ${DOTS_HOME}/bin
add_to_PATH ${DOTS_HOME}/bin-fn

# TODO: add_to_PATH_front (for the rest of these paths) via use/helpers/path.sh
add_to_PATH .
mkdir -p ~/bin
add_to_PATH ~/bin
[ ! -e ~/.bin ] && ln -s ~/bin ~/.bin # .bin symlink to bin for b-compatibility
add_to_PATH ~/deps/bin # see install/shell

export PATH # concludes what the PATH will be
