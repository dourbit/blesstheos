# Helpers for holy

shell-rc() {
  local shell=${1-$(basename $SHELL)}
  if [ $shell == "bash" ]; then
    echo ".bashrc"
  fi
}

installable() {
  local able=$1
  local path="${HOLY_HOME}/install/${able}"
  if [ $# -eq 0 ]; then
    find $HOLY_HOME/install -type f,l -executable -print \
    | sed -e "s/^.*\/install\///g" | sort \
    | grep -ve '\.sh$\|-skip$'
    # TODO: show help regarding what the above installs?
    true; return
  elif check-x $path; then
    true; return
  else
    false; return
  fi
}
