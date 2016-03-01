# dots -- dot-files source-stuff

I `git clone` and `. source.sh` this first through my `~/.bash_profile`:
`[ -f ~/.bashrc ] && . ~/.bashrc` and then for the goods with `.bashrc`:

```bash
HOME_DOTS=".dots"
. ~/.dots/source.sh

add_to_PATH ~/.dots/android/sdk/platform-tools #if installed here
```

This approach covers both login and non-login shells -- so far just `bash`.
Change `.dots` to wherever `dots` is cloned.  It has to be relative to `$HOME`,
though in the future perhaps absolute paths could be supported...

It's may be possible to put it in your `.profile`.
The bash-specific stuff should be contained in `use/bash.sh`.
Though I have not tried using all of this with other shells...

## License

[MIT](http://orlin.mit-license.org)
