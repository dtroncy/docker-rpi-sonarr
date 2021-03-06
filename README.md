# docker-rpi-sonarr

<img src="https://badgen.net/badge/platform/raspberry%20pi?list=1"/> <a href="https://hub.docker.com/r/dtroncy/rpi-sonarr"><img src="https://badgen.net/badge/icon/docker?icon=docker&label"/></a> <a href="https://travis-ci.org/dtroncy/docker-rpi-sonarr"><img src="https://badgen.net/travis/dtroncy/docker-rpi-sonarr/master?icon=travis&label=build"/></a>

This is a raspberry pi compatible Sonarr DockerFile.

To build it :

    docker build --build-arg sonarr_version=$sonarr_version -t rpi-sonarr .

$sonarr_version is version of sonarr you want to install.

To run it (with image on docker hub) :

    docker run -d -p 8989:8989 \
    -v /path_to_your_media_folder:/volumes/media \
    -v /path_to_your_download_folder:/volumes/download \
    -v /path_to_your_config_folder:/volumes/config \
    -v /etc/localtime:/etc/localtime:ro \
    --restart unless-stopped \
    --name sonarr \
    dtroncy/rpi-sonarr

Description of parameters :
  - **-d** : to launch container as demon
  - **-v /path_to_your_media_folder:/volumes/media** : mount media folder in your container to a folder in your host. The media folder is the folder where sonarr scan your actuals media
  - **-v /path_to_your_download_folder:/volumes/download** : mount download folder in your container to a folder in your host
  - **-v /path_to_your_config_folder:/volumes/config** : mount config folder in your container to a folder in your host
  - **-v /etc/localtime:/etc/localtime:ro** : synchronise time between host and container
  - **--restart unless-stopped** : restart the container unless it has been stopped by user
  - **--name sonarr** : container's name
  - **dtroncy/rpi-sonarr** : image's name
