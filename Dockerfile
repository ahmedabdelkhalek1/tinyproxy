# Build Tinyproxy from your fork
FROM alpine:3.20 AS build
RUN apk add --no-cache build-base autoconf automake libtool
WORKDIR /src
COPY . /src
RUN ./autogen.sh && ./configure --prefix=/opt/tinyproxy && make -j$(nproc) && make install

# Runtime image
FROM alpine:3.20
RUN adduser -S -D -H tinyproxy && apk add --no-cache ca-certificates
COPY --from=build /opt/tinyproxy /opt/tinyproxy
COPY tinyproxy.conf.template /etc/tinyproxy/tinyproxy.conf
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
USER tinyproxy
# Render will set PORT; default to 10000 if missing
ENV PORT=10000
# EXPOSE is optional on Render; port detection relies on binding to $PORT
EXPOSE 10000
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
