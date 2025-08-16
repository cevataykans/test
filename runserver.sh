#!/bin/bash

# Initialize Wine prefix if needed
if [ ! -d "/home/abiotic/.wine" ]; then
    wineboot --init
fi

xvfb-run wine64 abioticserver/AbioticFactor/Binaries/Win64/AbioticFactorServer-Win64-Shipping.exe -log -newconsole -useperfthreads -NoAsyncLoadingThread -MaxServerPlayers=6 -PORT=7777 -QUERYPORT=27015 -tcp -ServerPassword=dedicatedtest -SteamServerName="AbioticKAL" -WorldSaveName="Cascade"