# Sourced by `ipkgs`, this provides helpers.

# verify it's bash version >= 4
# for associative arrays, in use by ipkgs
if [ ${BASH_VERSION%%[^0-9]*} -lt 4 ]; then
  echo "Bash must be version 4 or greater."
  echo "Currently it's: '${BASH_VERSION}'."
  exit 1
fi
