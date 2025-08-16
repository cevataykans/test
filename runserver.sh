#!/bin/bash

# Initialize Wine prefix if needed
if [ ! -d "/home/abiotic/.wine" ]; then
    wineboot --init
fi

echo "checking for updates ..."
/usr/games/steamcmd +@sSteamCmdForcePlatformType windows +force_install_dir /home/abiotic/abioticserver +login anonymous +app_update 2857200 +quit
echo "Launching server ...." 
WINEDEBUG=fixme-all xvfb-run wine64 abioticserver/AbioticFactor/Binaries/Win64/AbioticFactorServer-Win64-Shipping.exe -log -newconsole -useperfthreads -NoAsyncLoadingThread -MaxServerPlayers=6 -PORT=7777 -QUERYPORT=27015 -tcp -ServerPassword=cevat -SteamServerName="CevatServer" -WorldSaveName="CevatWorld"