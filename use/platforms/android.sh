# NOTE: the following would either have to be added to `.bashrc`
# via install script, or sourced from here at some later point.
# Maybe stuff will change by the time I start using this again.

# for android development - one would also need to install java ...
export ANDROID_HOME=$HOME/.dots/android/sdk # if installed here ...
add_to_PATH $ANDROID_HOME/platform-tools
add_to_PATH $ANDROID_HOME/tools
