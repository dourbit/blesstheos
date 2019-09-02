# https://docs.docker.com/engine/reference/commandline/stats/
alias docker-stats='docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}"'
alias docker-ids='docker stats --format "table {{.PIDs}}\t{{.Container}}\t{{.Name}}" --no-stream'
alias docker-all='docker-ids --all'

# Container Shortcuts
alias bitcoind='docker exec -it btcnode bitcoind -datadir=/.bitcoin'
alias bitcoin-cli='docker exec -it btcnode bitcoin-cli -datadir=/.bitcoin'
alias bitcoin-log='sudo tail -f ~/data/btc/debug.log'
alias siac='docker exec -it sia ./siac'
