FROM ubuntu:24.04

RUN sudo useradd -m  abiotic
RUN sudo -u abiotic -s
USER abiotic
WORKDIR /home/abiotic

RUN sudo apt update && sudo apt upgrade -y
RUN sudo apt install software-properties-common lsb-release wget

RUN sudo mkdir -pm755 /etc/apt/keyrings
RUN sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
RUN sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/$(lsb_release -is | tr '[:upper:]' '[:lower:]')/dists/$(lsb_release -cs)/winehq-$(lsb_release -cs).sources

RUN sudo dpkg --add-architecture i386
RUN sudo apt update
RUN sudo apt install --install-recommends winehq-staging
RUN sudo apt install cabextract winbind screen xvfb

RUN sudo add-apt-repository multiverse
RUN sudo apt-add-repository non-free
RUN sudo apt update
RUN sudo apt install steamcmd

RUN mkdir /home/abiotic/abioticserver
RUN /usr/games/steamcmd +@sSteamCmdForcePlatformType windows +force_install_dir /home/abiotic/abioticserver +login anonymous +app_update 2857200 +quit

ENTRYPOINT ["echo", "Hello World!"]