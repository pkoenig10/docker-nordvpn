FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y curl && \
    curl https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb -o /tmp/nordvpn.deb && \
    apt-get install -y /tmp/nordvpn.deb && \
    apt-get update && \
    apt-get install -y nordvpn=3.8.5 && \
    rm -rf /tmp/* /var/lib/apt/lists/*

COPY ./nordvpn.sh /nordvpn.sh
RUN chmod +x /nordvpn.sh

ENTRYPOINT [ "/nordvpn.sh" ]
