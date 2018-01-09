FROM jrottenberg/ffmpeg

MAINTAINER Jaroslav Kostal <jaroslav@kostal.sk>

COPY entrypoint.sh entrypoint.sh

VOLUME /input
VOLUME /output

ENTRYPOINT ["./entrypoint.sh"]

