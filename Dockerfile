FROM ubuntu:24.04

WORKDIR /home/abiotic

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y software-properties-common lsb-release wget

RUN mkdir -pm755 /etc/apt/keyrings
RUN wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
RUN wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/$(lsb_release -is | tr '[:upper:]' '[:lower:]')/dists/$(lsb_release -cs)/winehq-$(lsb_release -cs).sources

RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get install -y --install-recommends winehq-staging
RUN apt-get install -y cabextract winbind screen xvfb

RUN add-apt-repository multiverse
RUN apt-get update
RUN apt-get install -y steamcmd

RUN mkdir /home/abiotic/abioticserver
RUN /usr/games/steamcmd +@sSteamCmdForcePlatformType windows +force_install_dir /home/abiotic/abioticserver +login anonymous +app_update 2857200 +quit

ENTRYPOINT ["echo", "Hello World!"]