FROM alpine:3.15

EXPOSE 9091 51413 51413/udp
VOLUME /transmission/config /transmission/download

ENV TRANSMISSION_HOME=/transmission/config

RUN apk --no-cache add tzdata transmission-daemon

USER transmission

COPY entrypoint.sh /transmission

ENTRYPOINT ["/transmission/entrypoint.sh"]
CMD ["transmission-daemon", "-f", "-w", "/transmission/download"]
