FROM ubuntu:latest

EXPOSE 27960/udp

ARG CNQ3_VERSION=1.51
ARG CPMA_VERSION=1.52

ARG CNQ3_CHECKSUM=8c1549a46436608bfa19f12a6eb4fa59222bff15
ARG CPMA_CHECKSUM=ba05bd0dd93c237fbadfd54c5afe8245019641e5
ARG MAPS_CHECKSUM=8a98cfc152f119da1b907f6431235ad3ccf89d59
ARG PK3S_CHECKSUM=840be8dfeffe9d7d4d791f333c34f004ff530ed8

RUN apt-get update && \
    apt-get install -y \
        wget \
        unzip \
        libunwind8 \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists && \
    \
    adduser --system --home /quake3 quake3

USER quake3:nogroup
WORKDIR /quake3

RUN wget -q -O /tmp/cnq3.zip https://cdn.playmorepromode.com/files/cnq3/cnq3-$CNQ3_VERSION.zip && \
    echo "$CNQ3_CHECKSUM  /tmp/cnq3.zip" | sha1sum -c - && \
    unzip /tmp/cnq3.zip && \
    rm /tmp/cnq3.zip  && \
    \
    rm ./*.exe ./cnq3-x64 && \
    chmod +x ./cnq3-server-x64 && \
    \
    wget -q -O /tmp/q3-pk3s.zip --header "Referer: https://ioquake3.org/extras/patch-data/" https://ioquake3.org/data/quake3-latest-pk3s.zip &&\
    echo "$PK3S_CHECKSUM  /tmp/q3-pk3s.zip" | sha1sum -c - && \
    unzip /tmp/q3-pk3s.zip && \
    rm /tmp/q3-pk3s.zip && \
    \
    mv ./quake3-latest-pk3s/* . && \
    rmdir ./quake3-latest-pk3s && \
    \
    wget -q -O /tmp/cpma.zip https://cdn.playmorepromode.com/files/cpma/cpma-$CPMA_VERSION-nomaps.zip && \
    echo "$CPMA_CHECKSUM  /tmp/cpma.zip" | sha1sum -c - && \
    unzip /tmp/cpma.zip && \
    rm /tmp/cpma.zip  && \
    \
    wget -q -O /tmp/maps.zip https://cdn.playmorepromode.com/files/cpma-mappack-full.zip && \
    echo "$MAPS_CHECKSUM  /tmp/maps.zip" | sha1sum -c - && \
    unzip -d ./baseq3 /tmp/maps.zip && \
    rm /tmp/maps.zip && \
    \
    ln -s /pak0.pk3 ./baseq3/pak0.pk3 && \
    ln -s /server.cfg ./cpma/server.cfg

COPY default-server.cfg /server.cfg

RUN ls -al /quake3

ENTRYPOINT ["./cnq3-server-x64"]
CMD [ \
    "+set dedicated 2", \
    "+set sv_master1 master.quake3arena.com:27950", \
    "+set sv_master2 master.ioquake3.org:27950", \
    "+set sv_master3 master.maverickservers.com:27950", \
    "+set sv_master4 master.quakeservers.net:27950", \
    "+set sv_master5 master.qtracker.com:27900", \
    "+set fs_game cpma", \
    "+set net_port 27960", \
    "+set ttycon 0", \
    "+set developer 0", \
    "+exec server.cfg", \
    "+map pro-q3dm6" \
]
