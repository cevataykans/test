# Abiotic Factor MacOS Server Hosting Guide

## Status

- README: work in progress.
- Docker, compose files: some more launch options must be integrated.
- Dockerfile should use a USER other than **root**: not implemented yet.

## Motivation

I was hosting Abiotic Factor on my PS5, playing with a friend (PC), we were excitedly crafting the new items we have 
unlocked. Suddenly, game crashes, making us lose significant progress as the progress was not saved. The game had been
giving me constant "save game" errors while we had been playing during that session. I should have taken these errors
more seriously.

We decided to start over from a dedicated server, sacrificing **~40** hours of progress. The problem was:
- I had a Macbook Pro with ARM architecture.
- Existing Abiotic Factor Linux containers did not run with Rosetta.

I had to see if I could use Rosetta without errors to run an Abiotic Factor dedicated server.

## Who This Project is For

If you have access to a:
- Linux machine with amd64 architecture (everything should work smoothly in theory)
- Macbook Pro (or similar) with Apple silicon (tested with M4 Pro)

The image has not been tested for:
- Linux machines with amd64 architecture.
- Older Macbook Pro models with Intel architecture.
- Linux machines with ARM architecture.
  - QEMU emulation may be too inefficient depending on hardware.

Windows machines can efficiently run the dedicated server without the workarounds here. Please refer to the [hosting guide](https://github.com/DFJacob/AbioticFactorDedicatedServer/wiki).

## Requirements (MacOS)

If you are not familiar with Docker, Docker Desktop is the simplest way for hosting your dedicated server.

- Install [Docker Desktop](https://docs.docker.com/desktop/setup/install/mac-install/)
- Go to "Settings".
  - Click on "General".
  - Scroll down to "Virtual Machine Options".
  - Choose "Apple Virtualization Framework".
  - Enable "Use Rosetta ... emulation on Apple Silicon".
  - Can choose "VirtuoFS" for file sharing implementation.
- Clone the repository or create a new folder.
  - Create a new file named **docker-compose.yaml**.
  - Copy contents of **compose-template.yaml** to this new file.
  - Edit the contents of **docker-compose.yaml**.
    - Important variables that should be changed:
      - ServerPassword
      - SteamServerName
      - AdminPassword (especially for console players)

You can customize how many resources the dedicated server will use by:
- Go to "Settings".
- Click "Resources".
- Choose the amount of CPU & Memory (RAM) Limits for the dedicated server.
  - The more the concurrent player count, the more resources server may need.
    - Especially if players explore different areas simultaneously.
  - Regularly watch server resource consumption by checking container stats using Docker Desktop.
  - If server requires more resources, or under utilizes resources, you can adjust the limits.
  - In case the server uses a lot of memory after some time (memory leaks), restarting the server may fix the problem.

## How to Run

- Open a terminal session at the folder where **docker-compose.yaml** is located.
- Run
```bash
docker compose up -d
```
- Server logs can be accessed on Docker Desktop.
- Look out for logs:
  - These logs indicate server is ready to be joined.
  - If any error message is being spammed, it may be better to restart the server.
  - If nothing gets printed, give the server some time, it may take some minutes to boot up.
```text
dedicated-server-1  | LogInit: Display: Game Engine Initialized.
dedicated-server-1  | LogInit: Display: Starting Game.
```
- Few seconds later, server code should also be printed. E.g:
```text
LogAbiotic: Warning: Session short code: 74Z1D
```
- If you cannot see your server name in the browser, try using the code to join.
- If you still cannot join the server, you may have to do port forwarding.
  - Ports **7777** and **27015** must be open for **tcp** and **udp**. 
- To stop the server, you can use Docker Desktop, or in Terminal as in the same folder, run:
```bash
docker compose down
```
- To apply updates (AutoUpdates variable should have been set to **true**), run:
```bash
docker compose restart
```
- Enjoy your server!

## FAQS

