if silent holy on platform/java; then

  # NOTE: for anything but Mac OS, $JAVA_HOME should be already exported

  if onMac; then
    export JAVA_HOME=$(/usr/libexec/java_home)
  fi

  PATH-add ${JAVA_HOME}

fi
