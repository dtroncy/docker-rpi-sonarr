# dtroncy/rpi-sonarr
FROM balenalib/rpi-raspbian

ARG sonarr_version

RUN cat /etc/os-release

RUN apt update
RUN apt install apt-transport-https dirmngr gnupg ca-certificates -y
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN echo "deb https://download.mono-project.com/repo/debian stable-raspbianbuster main" | tee /etc/apt/sources.list.d/mono-official-stable.list
RUN rpm -Uvh https://mediaarea.net/repo/rpm/releases/repo-MediaArea-1.0-19.noarch.rpm
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 2009837CBFFD68F45BC180471F4F90DE2A9B4BF8
RUN echo "deb https://apt.sonarr.tv/debian buster main" | tee /etc/apt/sources.list.d/sonarr.list
RUN apt update
RUN apt upgrade -y
RUN apt install sonarr=$sonarr_version -y
RUN apt clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN mkdir -p /volumes/config /volumes/media

## Expose port
EXPOSE 8989

## Volume for sonarr data
VOLUME /volumes/config /volumes/media
