# https://docs.docker.com/engine/reference/commandline/stats/
alias docker-stats='docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}"'
alias docker-ids='docker stats --format "table {{.PIDs}}\t{{.Container}}\t{{.Name}}" --no-stream'
alias docker-all='docker-ids --all'

# Container Shortcuts
# bitcoind @btcnode
alias bitcoind='docker exec -it btcnode bitcoind -datadir=/.bitcoin'
alias bitcoin-cli='docker exec -it btcnode bitcoin-cli -datadir=/.bitcoin'
alias bitcoin-log='sudo tail -f ~/data/btc/debug.log'
alias btcblock='BC_CURRENT=`bitcoin-cli getblockcount 2>&1`; BC_HEIGHT=`wget -O - http://blockchain.info/q/getblockcount 2>/dev/null`; perl -E "say sprintf(\"Block %s of %s (%.2f%%)\", $BC_CURRENT, $BC_HEIGHT, ($BC_CURRENT/$BC_HEIGHT)*100)";'
alias bc='bitcoin-cli'
alias bd='bitcoind'
# sia
alias siac='docker exec -it sia ./siac'
