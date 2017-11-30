FROM debian:latest

ENV FFSYNC_PORT 8080

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y python-dev git-core python-virtualenv g++ nano make

WORKDIR /opt/syncserver

RUN git clone --depth 1 -b master https://github.com/mozilla-services/syncserver .
RUN cp -R syncserver.ini /opt/syncserver/unmount_syncserver.ini
RUN make build

COPY entrypoint.sh /opt/syncserver
RUN apt-get update \
  && apt-get -qy install dos2unix \
  && dos2unix entrypoint.sh \
&& chmod +x entrypoint.sh

EXPOSE $FFSYNC_PORT
CMD ["make serve"]
ENTRYPOINT ["/opt/syncserver/entrypoint.sh"]
