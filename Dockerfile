FROM mcchae/xfce
MAINTAINER MoonChang Chae mcchae@gmail.com
LABEL Description="alpine desktop env with ide (over xfce with novnc, xrdp and openssh server)"

################################################################################
# install openjdk7
################################################################################
ENV JAVA_HOME=/usr/lib/jvm/default-jvm
RUN apk add --no-cache openjdk7 && \
    ln -sf "${JAVA_HOME}/bin/"* "/usr/bin/"

################################################################################
# pycharm
################################################################################
WORKDIR /usr/local
ENV IDEA_VER ideaIC-2017.2.2

RUN curl -SL https://download.jetbrains.com/idea/$IDEA_VER.tar.gz | \
		tar -f - -xz --exclude "idea*/jre64" -f - \
    && ln -s $(find /usr/local/* -name "idea*" -type d -maxdepth 0) /usr/local/idea \
    && if [ ! -d ${HOME}/.autoenv ];then git clone git://github.com/kennethreitz/autoenv.git ${HOME}/.autoenv; fi

WORKDIR /

ADD chroot/usr /usr

