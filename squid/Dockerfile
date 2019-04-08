FROM alpine:edge
RUN apk -U add --no-cache squid
COPY squid.conf /etc/squid/
CMD ["squid", "-N"]
