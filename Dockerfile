FROM debian:10.4-slim

EXPOSE 8080-8180
EXPOSE 5678-5688
EXPOSE 7777-7877
EXPOSE 19132/udp
EXPOSE 21025-21125
EXPOSE 25565-25665
EXPOSE 27015-27115
EXPOSE 28015-28115
EXPOSE 34197-34297
EXPOSE 38080-38080

ENV AMPUSER=admin
ENV AMPPASSWORD=changeme123
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

ENV BINDADDRESS=0.0.0.0
ENV PORT=8080

ENV PUID=1000
ENV PGID=100

ENV DATAPATH="/home/amp/.ampdata"

RUN mkdir /usr/share/man/man1 \
 && useradd -u $PUID -g $PGID -d /home/amp -m amp -s /bin/bash \
 && apt-get update \
 && apt-get install -y \
        locales-all \
        cron \
        lib32gcc1 \
        coreutils \
        inetutils-ping \
        tmux \
        socat \
        unzip \
        wget \
        git \
        screen \
        procps \
        lib32gcc1 \
        lib32stdc++6 \
        software-properties-common \
        dirmngr \
        apt-transport-https \
        openjdk-11-jre-headless \
        software-properties-common \
        dirmngr \
        apt-transport-https \
 #&& sed --in-place '/en_US.UTF-8/s/^#//' \
 #&& locale-gen en_US.UTF-8 \
 #&& dpkg-reconfigure --frontend=noninteractive locales \
 && update-locale LANG=en_US.UTF-8 \
 && apt-key adv --fetch-keys "http://repo.cubecoders.com/archive.key" \
 && apt-add-repository "deb http://repo.cubecoders.com/ debian/" \
 && apt-get update \
 && apt-get install ampinstmgr --install-suggests \
 && apt-get upgrade -y \
 && apt-get autoremove \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p ${DATAPATH} \
 && touch ${DATAPATH}/empty \
 && chown -R amp:${PGID} ${DATAPATH}

COPY "./usr/local/bin/docker-entrypoint.sh" /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

COPY "./home/amp/start.sh" /home/amp/
RUN chown amp:${PGID} /home/amp/start.sh
RUN chmod +x /home/amp/start.sh

VOLUME [${DATAPATH}]

WORKDIR ${DATAPATH}
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["/home/amp/start.sh"]
