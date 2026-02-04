# Terraria Dedicated Server

Containerized setup for running a **Terraria Dedicated Server** using Podman or Docker with persistent worlds and configurable settings.

---

## Features

- Automatic world creation
- Configurable server language, max players, password, and Journey mode permissions
- Persistent volumes for worlds
- Interactive server console for safe shutdown

---

## Configuration

Set server parameters via build arguments in `compose.yml`:

| Argument         | Default                            |
| ---------------- | ---------------------------------- |
| VERSION          | 1453                               |
| LANG             | en-US                              |
| WORLD_NAME       | world1                             |
| WORLD_SIZE       | 2                                  |
| WORLD_SEED       | AwesomeSeed                        |
| WORLD_DIFFICULTY | 2                                  |
| MAX_PLAYERS      | 6                                  |
| PASSWORD         | password                           |
| MOTD             | Please don’t cut the purple trees! |
| SECURE           | 1                                  |
| UPNP             | 0                                  |
| NPCSTREAM        | 60                                 |
| PRIORITY         | 1                                  |
| JOURNEY_*        | 2 (everyone)                       |

---

## Build and Start

```bash
podman compose -f ./compose.yml up -d
```

Exposes port `7777` and mounts `./data` as world storage.

---

## Access Server Console

```bash
podman attach dedicated-server-containers_terraria-server_1
```

- Type commands like `save` or `exit`.
- Detach without stopping container: `Ctrl+P` then `Ctrl+Q`.

---

## Stop Server Safely

1. Attach to console (see above)
2. Type:

```text
exit
```

> ⚠️ **WARNING:** avoid `SIGKILL` or `podman stop` without `exit`, because the world may not save.

---

## Volumes

The Terraria server stores worlds and backups in a host directory mounted into the container:

```bash
mkdir -p ./data
```

```yaml
volumes:
  - ./data:/opt/Terraria/worlds:Z
```

- `./data` is the host directory for world files and backups.
- You can change it to any path. Since the container runs as **root**, no UID/GID adjustment is required.
- The `:Z` flag ensures SELinux labels allow the container to read/write the volume.

---

## Ports

```yaml
ports:
  - "7777:7777"  # Host:Container
```

- The Terraria server listens on port `7777` inside the container.
- The first number (`7777`) is the host port players connect to.
- The second number (`7777`) is the container’s internal port.
- This forwards traffic from the host to the container, making the server reachable from the network.
