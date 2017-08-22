FROM mcchae/xfce
MAINTAINER MoonChang Chae mcchae@gmail.com
LABEL Description="alpine desktop env with ide (over xfce with novnc, xrdp and openssh server)"

################################################################################
# install openjdk7
################################################################################
ENV JAVA_HOME=/usr/lib/jvm/java-1.7-openjdk
RUN apk add --no-cache openjdk7
#    ln -sf "${JAVA_HOME}/bin/"* "/usr/bin/"

################################################################################
# install openjdk8
################################################################################
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
RUN { \
        echo '#!/bin/sh'; \
        echo 'set -e'; \
        echo; \
        echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
    } > /usr/local/bin/docker-java-home \
    && chmod +x /usr/local/bin/docker-java-home
ENV JAVA_VERSION 8u131
ENV JAVA_ALPINE_VERSION 8.131.11-r2
RUN set -x \
    && apk add --no-cache openjdk8="$JAVA_ALPINE_VERSION"
ENV PATH $PATH:${JAVA_HOME}/jre/bin:${JAVA_HOME}/bin

################################################################################
# pycharm
################################################################################
WORKDIR /usr/local
ENV IDEA_VER ideaIC-2017.2.2

RUN curl -SL https://download.jetbrains.com/idea/$IDEA_VER.tar.gz | \
		tar -f - -xz --exclude "idea*/jre64" -f - \
    && ln -s $(find /usr/local/* -name "idea*" -type d -maxdepth 0) /usr/local/idea

WORKDIR /

ADD chroot/usr /usr

