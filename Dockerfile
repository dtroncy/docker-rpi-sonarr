FROM resin/rpi-raspbian

ARG sonarr_version

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install libmono-cil-dev -y \
    && apt-get install wget \
    && wget http://sourceforge.net/projects/bananapi/files/mono_3.10-armhf.deb \
    && dpkg -i mono_3.10-armhf.deb \
    && rm mono_3.10-armhf.deb \
    && apt-get install apt-transport-https -y --force-yes \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC \
    && echo "deb https://apt.sonarr.tv/ master main" | sudo tee -a /etc/apt/sources.list.d/sonarr.list \
    && apt-get update \
    && apt-get install nzbdrone=$sonarr_version -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && mkdir -p /volumes/config /volumes/media

## Expose port
EXPOSE 8989

## Volume for sonarr data
VOLUME /volumes/config /volumes/media

## Entrypoint to launch Sonarr
ENTRYPOINT ["mono","/opt/NzbDrone/NzbDrone.exe", "-nobrowswer", "-data=/volumes/config"]
