#!/bin/bash

# Initialize Wine prefix
if [ ! -d "/home/abiotic/.wine" ]; then
    wineboot --init
fi

# Check for updates
if [[ $AutoUpdate == "true" ]]; then
   echo ""
   echo "***********"
   echo "Checking for auto updates..."
   echo "***********"
   echo ""
   /usr/games/steamcmd +@sSteamCmdForcePlatformType windows \
   +force_install_dir /home/abiotic/abioticserver \
   +login anonymous \
   +app_update 2857200 \
   +quit
fi

# Default variables
MaxServerPlayers="${MaxServerPlayers:-6}"
Port="${Port:-7777}"
QueryPort="${QueryPort:-27015}"
ServerPassword="${ServerPassword:-}"
SteamServerName="${SteamServerName:-Dedicated Server}"
WorldSaveName="${WorldSaveName:-Cascade}"
AdminPassword="${AdminPassword:-}"
OverrideSandboxPath="${OverrideSandboxPath:-}"
AdditionalArgs="${AdditionalArgs:-}"

SetUsePerfThreads="-useperfthreads"
if [[ $UsePerfThreads == "false" ]]; then
    SetUsePerfThreads=""
fi

SetNoAsyncLoadingThread="-NoAsyncLoadingThread"
if [[ $NoAsyncLoadingThread == "false" ]]; then
    SetNoAsyncLoadingThread=""
fi

SetAdminPassword=""
if [[ $AdminPassword != "" ]]; then
    SetAdminPassword="-AdminPassword=${AdminPassword}"
fi

echo ""
echo "***********"
echo "Launching abiotic game server..."
echo "***********"
echo ""
WINEDEBUG=fixme-all xvfb-run wine64 abioticserver/AbioticFactor/Binaries/Win64/AbioticFactorServer-Win64-Shipping.exe \
   -log -newconsole \
   $SetUsePerfThreads $SetNoAsyncLoadingThread \
   -PORT=$Port -QUERYPORT=$QueryPort -tcp \
   -MaxServerPlayers=$MaxServerPlayers -WorldSaveName="$WorldSaveName" \
   -SteamServerName="$SteamServerName" -ServerPassword=${ServerPassword} $SetAdminPassword \
   $OverrideSandboxPath \
   $AdditionalArgs