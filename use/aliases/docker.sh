# https://docs.docker.com/engine/reference/commandline/stats/
alias docker-id='docker stats --format "table {{.PIDs}}\t{{.Container}}\t{{.Name}}"'
alias docker-stats='docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}"'

# Container Shortcuts
alias siac='docker exec -it sia ./siac'
