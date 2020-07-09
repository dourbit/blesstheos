# NOTE: for anything but Mac OS, export JAVA_HOME before sourcing .holy

if onMac; then
  export JAVA_HOME=$(/usr/libexec/java_home)
fi

add_to_PATH ${JAVA_HOME}
