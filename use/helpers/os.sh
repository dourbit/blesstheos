export KERNEL_NAME=$(uname -s)

onMac() {
  if [ "$KERNEL_NAME" == 'Darwin' ]; then true; return; fi
  false; return
}
export -f onMac

onLinux() {
  if [ "$KERNEL_NAME" == 'Linux' ]; then true; return; fi
  false; return
}
export -f onLinux


if onLinux; then export DISTRO_ID=$(lsb_release -i | awk '{print $NF}'); fi

onApt() {
  # NOTE: other distros are also apt - check for command instead?
  if [ "$DISTRO_ID" == 'Ubuntu' ] ||
     [ "$DISTRO_ID" == 'Debian' ]; then true; return; fi
  false; return
}
export -f onApt

onUbuntu() {
  if [ "$DISTRO_ID" == 'Ubuntu' ]; then true; return; fi
  false; return
}
export -f onUbuntu
