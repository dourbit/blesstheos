#!/usr/bin/env bash

# Note: sh extension is for Atom to not treat it as Clojure code.

# Based on https://purelyfunctional.tv/guide/how-to-install-clojure/
# https://clojure.org/guides/getting_started#_installation_on_linux
# Version copied from the above link.
# TODO: make this a global, exported environment variable,
# for a fixed yet configurable version useful in production,
# which should override brew install; still also ...
# keep the version below as fallback in non-brew scenarios
CLOJURE_V="1.10.1.536"

# Using: brewOn sudoUse sudomy specho
# Also many bin-fn scripts, which can be sourced.
holy-dot src/ install util

sudoUse

# Expected deps
echo $JAVA_HOME
java -version
# NOTE: this will become irrelevant with $HOLY_CLOJURE_V (make it conditional)
brewOn && brew --version

# Leiningen
specho Leiningen ...
sudomy gh-install technomancy/leiningen bin/lein /usr/local/bin stable

# Leiningen User Profiles
LPROF=".lein/profiles.clj"
# NOTE: would be nice to merge the profiles rather than the simple off / on
[[ -f "$HOME/$LPROF" ]] || cp -r ${HOLY_HOME}/files/${LPROF} ~/${LPROF}
lein version

# Clj-kondo
# https://github.com/borkdude/clj-kondo
specho Clj-kondo ...
if brewOn; then
  brew install borkdude/brew/clj-kondo
else
  sudomy gh-install-xr borkdude/clj-kondo script/install-clj-kondo ~/tmp
fi
clj-kondo --version

# Clojure - rarely installed, change $CLOJURE_V at the top to reinstall another
specho Clojure ...
if brewOn; then brew install clojure/tools/clojure
elif onLinux && curl-report https://download.clojure.org/install/linux-install-${CLOJURE_V}.sh --create-dirs -o ~/tmp/linux-install-${CLOJURE_V}.sh; then
  sudomy install-xr ~/tmp/linux-install-${CLOJURE_V}.sh
fi

# There is a scenario for not brewOn && not onLinux,
# when Clojure may not be installed ...
if check-x clj; then
  clj -M -e '(println (str "Clojure " (clojure-version)))'
else echo "Clojure not installed."; fi
