# Terraria Dedicated Server

## Build Image

```bash
podman build --tag terraria:latest --format docker .
```

## Create Container

```bash
podman create -it --name terraria-server \
    -p 7777:7777/tcp \
    -v ./data/worlds/:/root/.local/share/Terraria/Worlds/:z \
    -v ./data/config/:/root/config/:z \
    terraria:latest "$GAME_VERSION"
```

## Start Container

```bash
podman start terraria-server
```

## Stop Container

```bash
podman exec -it terraria-server tmux send-keys -t terraria:0.0 "exit" Enter
```

## Attatch console

```bash
podman exec -it terraria-server tmux attach -t terraria
```

> Use `CTRL-B Q` to detach from the console.
