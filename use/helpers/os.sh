system_name=$(uname -s)

onMac() {
  if [ "$system_name" == 'Darwin' ]; then true; return; fi
  false; return
}

onLinux() {
  if [ "$system_name" == 'Linux' ]; then true; return; fi
  false; return
}

onApt() {
  if [ isLinux ] && [ -f /etc/issue.net ]; then
    local etn=$(cat /etc/issue.net | cut -f 1 -d " ")
    if [ "$etn" == 'Ubuntu' ] || [ "$etn" == 'Debian' ] ; then true; return; fi
  fi
  false; return
}

onUbuntu() {
  if [ isLinux ] && [ -f /etc/issue.net ]; then
    local etn=$(cat /etc/issue.net | cut -f 1 -d " ")
    if [ "$etn" == 'Ubuntu' ]; then true; return; fi
  fi
  false; return
}
