# https://docs.docker.com/engine/reference/commandline/stats/
alias docker-stats='docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}"'
alias docker-ids='docker stats --format "table {{.PIDs}}\t{{.Container}}\t{{.Name}}" --no-stream'
alias docker-all='docker-ids --all'

# Container Shortcuts
alias siac='docker exec -it sia ./siac'
