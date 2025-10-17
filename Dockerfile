# Build Tinyproxy from your fork
FROM alpine:3.20 AS build
RUN apk add --no-cache build-base autoconf automake libtool
WORKDIR /src
COPY . /src
RUN ./autogen.sh && ./configure --prefix=/opt/tinyproxy && make -j$(nproc) && make install

# Runtime image
FROM alpine:3.20
RUN apk add --no-cache ca-certificates su-exec
COPY tinyproxy.conf.template /etc/tinyproxy/tinyproxy.conf
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
# run entrypoint as root so it can write under /etc
USER root
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
