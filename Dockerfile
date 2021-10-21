# dtroncy/rpi-sonarr
FROM balenalib/rpi-raspbian

ARG sonarr_version

RUN apt update \
&& apt install apt-transport-https dirmngr gnupg ca-certificates -y \
&& apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
&& echo "deb https://download.mono-project.com/repo/debian stable-raspbianbuster main" | tee /etc/apt/sources.list.d/mono-official-stable.list \
&& apt install wget \
&& wget https://mediaarea.net/repo/deb/repo-mediaarea_1.0-19_all.deb && dpkg -i repo-mediaarea_1.0-19_all.deb && apt-get update \
&& apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 2009837CBFFD68F45BC180471F4F90DE2A9B4BF8 \
&& echo "deb https://apt.sonarr.tv/debian buster main" | tee /etc/apt/sources.list.d/sonarr.list \
&& apt update \
&& apt upgrade -y \
&& apt install sonarr=$sonarr_version -y \
&& apt clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
&& mkdir -p /volumes/config /volumes/media

## Expose port
EXPOSE 8989

## Volume for sonarr data
VOLUME /volumes/config /volumes/media
