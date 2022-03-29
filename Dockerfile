FROM eqalpha/keydb:alpine

RUN apk -U add bash

COPY utils /usr/bin/
COPY etc /etc/

CMD ["/usr/bin/hivemind", "/etc/Procfile"]