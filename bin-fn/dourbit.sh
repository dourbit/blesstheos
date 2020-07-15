# Helpers of dourbit

docker-image() {
  env-have $URBIT_IMAGE && echo $URBIT_IMAGE || echo "asssaf/urbit:latest"
}

repos() {
  echo "${HOLY_HOME}/use/repos"
}

eager() {
  # git fetch and docker pull only with dourbit update, unless $URBIT_EAGER=true
  $(env-true $URBIT_EAGER)
}

fetch() {
  local tagpref=${1-'urbit-'}
  local refspec="refs/tags/${tagpref}*:refs/tags/${tagpref}*"
  cd $(repos)/urbit
  git fetch --depth=1 origin "$refspec"
}

silent-fetch() {
  if eager; then fetch >/dev/null 2>&1; fi
}

silent-pull() {
  if eager && docker-image | grep -qe ':latest$'; then
    # if an image isn't tagged latest: assume fixed version / need not pull
    # furthermore $URBIT_EAGER must be set in order to pull
    silent docker pull $(docker-image)
  fi
}

tagged() {
  # NOTE: dourbit latest #calls this twice so we can't fetch here
  # excluding .rc tags
  local filter=${2-'\.rc'} # ideally comes from $URBIT_TAGS_FILTER
  # TODO: conditional filter - empty string, or no var set: so it won't filter
  # https://unix.stackexchange.com/questions/38310/conditional-pipeline#38312
  cd $(repos)/urbit
  git tag -l "${1}*" --format='%(creatordate:short)%09%(refname:strip=2)' \
                     --sort=-creatordate | grep -v -e "$filter"
}

latest() {
  tagged "$@" | head -n 1
}

toptag() {
  # given a command that produces tags same as tagged function above or similar
  $@ | head -n 1 \
     | grep -oe '[[:blank:]]\+.*$' \
     | tr   -d   '[:blank:]'
}
