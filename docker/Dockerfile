FROM alpine:3.17.0

EXPOSE 9091 51413 51413/udp

ENV TRANSMISSION_HOME=/transmission/config

RUN apk --no-cache add tzdata transmission-daemon && \
	mkdir -p /transmission/config /transmission/download

USER transmission

COPY entrypoint.sh /transmission

VOLUME /transmission/config /transmission/download

ENTRYPOINT ["/transmission/entrypoint.sh"]
CMD ["transmission-daemon", "-f", "-w", "/transmission/download"]
