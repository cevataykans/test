FROM ubuntu:24.04

RUN useradd -m abiotic
USER abiotic
WORKDIR /home/abiotic

RUN apt update sudo apt upgrade -y
RUN apt install software-properties-common lsb-release wget

RUN mkdir -pm755 /etc/apt/keyrings
RUN wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
RUN wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/$(lsb_release -is | tr '[:upper:]' '[:lower:]')/dists/$(lsb_release -cs)/winehq-$(lsb_release -cs).sources

RUN dpkg --add-architecture i386
RUN apt update
RUN apt install --install-recommends winehq-staging
RUN apt install cabextract winbind screen xvfb

RUN add-apt-repository multiverse
RUN apt-add-repository non-free
RUN apt update
RUN apt install steamcmd

mkdir /home/abiotic/abioticserver
RUN /usr/games/steamcmd +@sSteamCmdForcePlatformType windows +force_install_dir /home/abiotic/abioticserver +login anonymous +app_update 2857200 +quit

ENTRYPOINT ["echo", "Hello World!"]