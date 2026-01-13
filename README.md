# Hytale Dedicated Server

# Build

```sh
podman build --tag hytale:latest --format docker .
```

# Create container

```sh
podman create -ti --name hytale-server \
    -p 5520:5520/udp \
    -v ./data:/srv/data \
    hytale:latest
```
