# Garry's Mod Dedicated Server in Docker

# Linux Container
[![](https://images.microbadger.com/badges/version/lacledeslan/gamesvr-garrysmod.svg)](https://microbadger.com/images/lacledeslan/gamesvr-garrysmod "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/lacledeslan/gamesvr-garrysmod.svg)](https://microbadger.com/images/lacledeslan/gamesvr-garrysmod "Get your own image badge on microbadger.com")

**Download**

```
docker pull lacledeslan/gamesvr-garrysmod
```

**Run Interactive Server**
```
docker run -it --rm lacledeslan/gamesvr-garrysmod ./srcds_run -game garrysmod +map gm_construct +sv_lan 1 +maxplayers 32";
```

**Run Self Tests**
```
docker run -it --rm lacledeslan/gamesvr-garrysmod ./ll-tests/gamesvr-garrysmod.sh
```
