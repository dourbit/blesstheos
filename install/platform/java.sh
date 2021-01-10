#!/usr/bin/env bash

# Java 11 (LTS)
# Only for onApt operating systems - Debian, Ubuntu, etc.
# https://adoptopenjdk.net/installation.html?variant=openjdk11&jvmVariant=hotspot#linux-pkg
java_home="/usr/lib/jvm/adoptopenjdk-11-hotspot-amd64"

# Note: the sh extension is for Atom to not treat it as Java code

# Using: onApt
holy-dot src/ os install

if onApt; then
  sudo apt install -y software-properties-common
  wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | sudo apt-key add -
  sudo-add-apt-repository https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/
  sudo-apt-update
  sudo apt install -y adoptopenjdk-11-hotspot
else
  echo "You may need to setup java manually, let's see what you have installed:"
  tis-some $JAVA_HOME && echo "JAVA_HOME=\"${JAVA_HOME}\"" \
    || echo "Not Set: \$JAVA_HOME"
  check-x java && java -version || echo "Not Found: java"
  # Error exit - will have to holy bless ...
  exit 1
fi

if [ "$JAVA_HOME" != "$java_home" ]; then
  if tis-some $JAVA_HOME; then
    echo
    echo 'Change of $JAVA_HOME'
    echo "Before: $JAVA_HOME"
    echo "Now is: $java_home"
    echo "Please make sure the variable is set correctly."
  fi
  export JAVA_HOME="$java_home"

  # Only if this is a first-time install:
  # TODO: rather than looking at .bashrc contents wait for holy env ...
  # upcoming env vars functionality that will help improve this
  if ! holy on platform/java > /dev/null; then
    echo '' >> ~/.bashrc # add an empty line spacer
    echo "export JAVA_HOME=$java_home" >> ~/.bashrc
  fi
fi

echo
echo "JAVA_HOME=\"${JAVA_HOME}\""
java -version
