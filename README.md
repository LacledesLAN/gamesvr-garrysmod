# Garry's Mod Dedicated Server in Docker

Garry's Mod (GMod) is a sandbox physics game created by Garry Newman originally a mod for Half-Life 2 but was later made into a standalone release. The base game mode "sandbox" has no set objectives, and gives the player the freedom to spawn non-player characters (NPCs), ragdolls or objects (called props), such as furniture, shipping containers, dumpsters and explosions, and interact with them in various ways. Garry's Mod allows users to take advantage of the extensibility of the Source Engine through the spawn menu which enables users to spawn models and maps imported by the user.

![Garry's Mod](https://raw.githubusercontent.com/LacledesLAN/gamesvr-garrysmod/master/.misc/gmod-art.jpg "Garry's Mod")

This repository is maintained by [Laclede's LAN](https://lacledeslan.com). Its contents are intended to be bare-bones and used as a stock server. If any documentation is unclear or it has any issues please see [CONTRIBUTING.md](./CONTRIBUTING.md).

## Linux Container

[![linux/amd64](https://github.com/LacledesLAN/gamesvr-garrysmod/actions/workflows/build-linux-image.yml/badge.svg?branch=master)](https://github.com/LacledesLAN/gamesvr-garrysmod/actions/workflows/build-linux-image.yml)

### Download

```
docker pull lacledeslan/gamesvr-garrysmod
```

### Run Interactive Server

```shell
docker run -it --rm lacledeslan/gamesvr-garrysmod ./srcds_run -game garrysmod +map gm_construct +sv_lan 1 +maxplayers 32";
```

### Run Self Tests

The image includes a test script that can be used to verify its contents. No changes or pull-requests will be accepted to this repository if any tests fail.

```shell
docker run -it --rm lacledeslan/gamesvr-garrysmod ./ll-tests/gamesvr-garrysmod.sh
```

## Getting Started with Game Servers in Docker

[Docker](https://docs.docker.com/) is an open-source project that bundles applications into lightweight, portable, self-sufficient containers. For a crash course on running Dockerized game servers check out [Using Docker for Game Servers](https://github.com/LacledesLAN/README.1ST/blob/master/GameServers/DockerAndGameServers.md). For tips, tricks, and recommended tools for working with Laclede's LAN Dockerized game server repos see the guide for [Working with our Game Server Repos](https://github.com/LacledesLAN/README.1ST/blob/master/GameServers/WorkingWithOurRepos.md). You can also browse all of our other Dockerized game servers: [Laclede's LAN Game Servers Directory](https://github.com/LacledesLAN/README.1ST/tree/master/GameServers).
