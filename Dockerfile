FROM alpine:edge

# Define software versions.
ENV FILEBOT_VERSION="5.2.3"
ENV FILEBOT_URL="https://get.filebot.net/filebot/FileBot_$FILEBOT_VERSION/FileBot_$FILEBOT_VERSION-portable.tar.xz"
ENV FILEBOT_SHA256="0dae8364f9d465707ff30031d055dcc7c6b24907d96823ced3d4e979f1519d0c"
ENV FILEBOT_HOME="/opt/filebot"

# update upgrade and install dependencies
RUN echo http:"//dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
  apk update && apk upgrade && apk add --no-cache \
  xvfb x11vnc openbox mediaelch supervisor bash novnc websockify \
  adwaita-icon-theme font-dejavu xdotool dos2unix zenity coreutils \
  libmediainfo tinyxml2 openjdk17-jre java-jna-native

# Download and extract Filebot
RUN mkdir -p /data
RUN set -eux \
 ## * fetch portable package
 && wget -O /tmp/filebot.tar.xz "$FILEBOT_URL" \
 && echo "$FILEBOT_SHA256 */tmp/filebot.tar.xz" | sha256sum -c - \
 ## * install application files
 && mkdir -p "$FILEBOT_HOME" \
 && tar --extract --file /tmp/filebot.tar.xz --directory "$FILEBOT_HOME" --verbose \
 && rm -v /tmp/filebot.tar.xz \
 ## * delete incompatible native binaries
 && find /opt/filebot/lib -type f -not -name libjnidispatch.so -delete \
 ## * link /opt/filebot/data -> /data to persist application data files to the persistent data volume
 && ln -s /data /opt/filebot/data
# create symlink for noVNC config
RUN ln -s /usr/share/novnc/vnc_lite.html /usr/share/novnc/index.html

# Add files.
COPY rootfs/ /

# Dos2Unix all files
RUN dos2unix /entry.sh
RUN dos2unix /etc/supervisord.conf
RUN dos2unix /etc/xdg/openbox/rc.xml

# Make entrypoint executable
RUN chmod +x /entry.sh

ENV DISPLAY=:0
ENV RESOLUTION=1366x768
ENV HOME="/data"
ENV LANG="C.UTF-8"
ENV FILEBOT_OPTS="-Dapplication.deployment=docker -Dnet.filebot.archive.extractor=ShellExecutables -Duser.home=$HOME"

EXPOSE 5900 8080

ENTRYPOINT ["/bin/bash", "-c", "/entry.sh"]

LABEL maintainer="Alan Doyle<me@alandoyle.com>"
