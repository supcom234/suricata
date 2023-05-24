from ubuntu:22.04 as builder

ENV VER 7.0.0-rc1
ENV URL https://www.openinfosecfoundation.org/download/suricata-${VER}.tar.gz
ENV MAXMIND_URL https://devnexus.ultraman.cnaps.io/repository/vcloud-files/maxmind%2FGeoLite2-Country_20230516.tar.gz

COPY /docker-entrypoint.sh /
RUN apt update && \
    apt-get install -y build-essential libpcap-dev \
        libnet1-dev libyaml-0-2 libyaml-dev pkg-config zlib1g zlib1g-dev \
        libcap-ng-dev libcap-ng0 make libmagic-dev libluajit-5.1-dev && \
    apt-get install -y libgeoip-dev liblua5.1-dev libhiredis-dev libevent-dev \
        python3-yaml rustc cargo libpcre2-dev libjansson-dev vim curl libmaxminddb-dev && \
    mkdir /etc/suricata && \
    mkdir /var/lib/suricata && \
    mkdir /var/log/suricata && \
    curl -L ${URL} | tar xvzf - && \
    curl -k -L ${MAXMIND_URL} | tar xzvf - && \
    cd /suricata-${VER} && \
    ./configure --disable-gccmarch-native \
                --enable-rust \
                --enable-libmagic \
                --enable-luajit \
                --enable-geoip \
                --enable-nfqueue \
                --enable-hiredis \
                --enable-libnss \
                --enable-libnspr \
                --disable-suricata-update \
                --sysconfdir=/etc \
                --enable-af-packet \
                --prefix=/usr/local/suricata-${VER} \
                --localstatedir=/var && \
    make && \
    make install && \
    ldconfig && \
    chmod 755 /docker-entrypoint.sh

#Build final image
from ubuntu:22.04
ENV VER 7.0.0-rc1

RUN mkdir /etc/suricata && \
    mkdir /var/lib/suricata && \
    mkdir /var/log/suricata && \
    mkdir /etc/suricata/lua-output/ && \
    mkdir /usr/local/share/GeoLite2

COPY --from=builder /docker-entrypoint.sh /docker-entrypoint.sh
COPY --from=builder /usr/local/suricata-${VER} /usr/local
COPY --from=builder /usr/lib/x86_64-linux-gnu/libevent_pthreads-2.1.so.7 \
                    /usr/lib/x86_64-linux-gnu/libevent-2.1.so.7 \
                    /usr/lib/x86_64-linux-gnu/libhiredis.so.0.14 \
                    /usr/lib/x86_64-linux-gnu/libmaxminddb.so.0 \ 
                    /usr/lib/x86_64-linux-gnu/libmagic.so.1 \
                    /usr/lib/x86_64-linux-gnu/libnet.so.1 \
                    /usr/lib/x86_64-linux-gnu/libjansson.so.4 \
                    /usr/lib/x86_64-linux-gnu/libyaml-0.so.2 \
                    /usr/lib/x86_64-linux-gnu/libpcap.so.0.8 \
                    /usr/lib/x86_64-linux-gnu/libluajit-5.1.so.2 \
                    /usr/lib/x86_64-linux-gnu/libevent_core-2.1.so.7 \
                    /usr/lib/x86_64-linux-gnu/libdbus-1.so.3 \
                    /usr/lib/x86_64-linux-gnu/

COPY --from=builder /usr/lib/file/magic.mgc /usr/lib/file/
COPY --from=builder /etc/magic /etc/magic
COPY --from=builder /GeoLite2-Country_20230516/GeoLite2-Country.mmdb /usr/local/share/GeoLite2/GeoLite2-Country.mmdb
COPY --from=builder /etc/magic.mime /etc/magic.mime
COPY --from=builder /suricata-${VER}/suricata.yaml \
     /suricata-${VER}/etc/classification.config \
     /suricata-${VER}/etc/reference.config \
     /suricata-${VER}/threshold.config \
     /etc/suricata

RUN ldconfig && \
    mkdir /nsm_pcaps && \
    mkdir -p /usr/lib/file && \
    mkdir -p /usr/share/file/ && \
    mkdir -p /usr/share/misc/magic && \
    ln -s /usr/lib/file/magic.mgc /usr/share/file/magic.mgc && \
    apt update && \
    apt install iproute2 nload logrotate python3 -y

VOLUME ["/var/log/suricata"]
VOLUME ["/var/lib/suricata"]
VOLUME ["/etc/suricata"]

ENTRYPOINT ["/docker-entrypoint.sh"]