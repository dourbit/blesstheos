
# NOTE: on a Mac, one must setup the /Applications/GHC.app (download, extract and rename)
# http://ghcformacosx.github.io/
if [ $system_name == 'Darwin' ]; then
  add_to_PATH /Applications/GHC.app/Contents/bin
fi

add_to_PATH ~/.cabal/bin

# https://halcyon.sh/
eval "$( HALCYON_NO_SELF_UPDATE=1 "/app/halcyon/halcyon" paths )"
