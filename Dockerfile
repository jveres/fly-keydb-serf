FROM eqalpha/keydb:alpine

RUN apk -U add bash tmux

COPY utils /usr/bin/
COPY etc /etc/

CMD /usr/bin/overmind start -N -r keydb,prom_exporter,serf,check_replicas -f /etc/Procfile