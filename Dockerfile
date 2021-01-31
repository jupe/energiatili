FROM rust:alpine3.12

#RUN set -e \
#    && apt update \
#    && apt install gettext

RUN set -x \
    # This folder is in $PATH by default but isn't created by default
    && mkdir -p /usr/local/sbin \
    && cd /usr/local/sbin \
    # Install envsubst command for replacing config files in system startup
    # - it needs libintl package
    # - only weights 100KB combined with it's libraries
    && apk add --no-cache musl-dev gettext libintl openssl-dev

WORKDIR /root
ENV PATH=/root/.cargo/bin:${PATH}

COPY . .

RUN set -e \
    && mkdir .config \
    && cargo install --path energiatili-import && cargo install --path influxdb-export

ENTRYPOINT ["entrypoint.sh"]
