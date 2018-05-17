# dtroncy/rpi-sonarr
FROM resin/rpi-raspbian

ARG sonarr_version

RUN apt-get update \
    && apt-get install apt-transport-https dirmngr -y \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
    && echo "deb https://download.mono-project.com/repo/debian stable-raspbianjessie main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC \
    && echo "deb https://apt.sonarr.tv/ master main" | sudo tee -a /etc/apt/sources.list.d/sonarr.list \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install wget \
    && apt-get install mono-devel -y \
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
