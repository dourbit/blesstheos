# identifies operating systems, many scripts use these
# run `check-os` for a report on which functions match the current os

export KERNEL_NAME=$(uname -s)

onMac() {
  if [ "$KERNEL_NAME" == 'Darwin' ]; then true; return; fi
  false; return
}

onLinux() {
  if [ "$KERNEL_NAME" == 'Linux' ]; then true; return; fi
  false; return
}

if onLinux; then export DISTRO_ID=$(lsb_release -i | awk '{print $NF}'); fi

onApt() {
  if onLinux && [ -x "$(command -v apt)" ]; then true; return; fi
  false; return
}

onUbuntu() {
  if [ "$DISTRO_ID" == 'Ubuntu' ]; then true; return; fi
  false; return
}
