FROM alpine:3.7

RUN mkdir /home/energiatili
WORKDIR /home/energiatili

RUN set -x \
    # This folder is in $PATH by default but isn't created by default
    && mkdir -p /usr/local/sbin \
    && cd /usr/local/sbin \
    # Install envsubst command for replacing config files in system startup
    # - it needs libintl package
    # - only weights 100KB combined with it's libraries
    && apk add gettext libintl
ENV PATH=/home/energiatili/:${PATH}

COPY ./energiatili.tmpl .
COPY ./bin/energiatili-import .
COPY ./bin/influxdb-export .
COPY ./entrypoint.sh .

ENTRYPOINT ["entrypoint.sh"]
