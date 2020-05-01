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

onApt() {
  if [ onLinux ] && [ -f /etc/issue.net ]; then
    local etn=$(cat /etc/issue.net | cut -f 1 -d " ")
    if [ "$etn" == 'Ubuntu' ] || [ "$etn" == 'Debian' ] ; then true; return; fi
  fi
  false; return
}
export -f onApt

onUbuntu() {
  if [ onLinux ] && [ -f /etc/issue.net ]; then
    local etn=$(cat /etc/issue.net | cut -f 1 -d " ")
    if [ "$etn" == 'Ubuntu' ]; then true; return; fi
  fi
  false; return
}
export -f onUbuntu
