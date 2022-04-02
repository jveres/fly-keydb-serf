FROM eqalpha/keydb:alpine

RUN apk -U add bash tmux

COPY utils /usr/local/bin/
COPY etc /etc/

CMD overmind start -N -r keydb,prom_exporter,serf,check_replicas -f /etc/Procfile