# identifies operating systems, many scripts use these
# run `check-os` for a report on which functions match the current os

export HOLY_KERNEL=$(uname -s)

onMac() {
  if [ "$HOLY_KERNEL" == 'Darwin' ]; then true; return; fi
  false; return
}

onLinux() {
  if [ "$HOLY_KERNEL" == 'Linux' ]; then true; return; fi
  false; return
}

if onLinux; then export HOLY_DISTRO=$(lsb_release -i | awk '{print $NF}'); fi

onApt() {
  if onLinux && [ -x "$(command -v apt)" ]; then true; return; fi
  false; return
}

onUbuntu() {
  if [ "$HOLY_DISTRO" == 'Ubuntu' ]; then true; return; fi
  false; return
}
