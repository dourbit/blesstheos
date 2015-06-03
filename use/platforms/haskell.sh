
# NOTE: on a Mac, one must setup the /Applications/GHC.app (download, extract and rename)
# http://ghcformacosx.github.io/
if [ $system_name == 'Darwin' ]; then
  add_to_PATH /Applications/GHC.app/Contents/bin
fi

add_to_PATH ~/.cabal/bin

# https://halcyon.sh/
# I'd like to use the above, however there are some issues with it...
# https://github.com/mietek/halcyon/issues/23
# https://github.com/mietek/halcyon/issues/16
# When it's all good - skip the ghcformacosx.github.io in favor of halcyon.
# eval "$( HALCYON_NO_SELF_UPDATE=1 "/app/halcyon/halcyon" paths )"
