# Docker container for Filebot
[![Docker Image Size](https://img.shields.io/docker/image-size/alandoyle/filebot/latest?logo=docker&style=for-the-badge)](https://hub.docker.com/r/alandoyle/filebot/tags)
[![Docker Pulls](https://img.shields.io/docker/pulls/alandoyle/filebot?label=Pulls&logo=docker&style=for-the-badge)](https://hub.docker.com/r/alandoyle/filebot)
[![Source](https://img.shields.io/badge/Source-GitHub-blue?logo=github&style=for-the-badge)](https://github.com/alandoyle/docker-filebot)

This is a Docker container for [Filebot](https://www.filebot.net/).

The graphical user interface (GUI) of the application can be accessed through a
modern web browser, requiring no installation or configuration on the client.

---

[![Filebot logo](https://images.weserv.nl/?url=raw.githubusercontent.com/alandoyle/docker-filebot/main/Filebot-logo.png&w=110)](https://www.filebot.net/)[![Filebot](https://images.placeholders.dev/?width=256&height=110&fontFamily=monospace&fontWeight=400&fontSize=52&text=Filebot&bgColor=rgba(0,0,0,0.0)&textColor=rgba(121,121,121,1))](https://www.filebot.net/)

Filebot is the ultimate tool for renaming and organizing your movies, TV shows and Anime.

---

## Docker

Available on [DockerHub](https://hub.docker.com/r/alandoyle/filebot)
```bash
docker pull alandoyle/filebot
```

---

## Usage

```bash
docker run --name=filebot \
  -d --init \
  -v <MY_DATA_PATH>:/data \
  -v <MY_MEDIA_PATH>:/media \
  -p 80:8080/tcp \
  -p 5900:5900/tcp \
  alandoyle/filebot:latest
```

Docker compose example:

```yaml
---
services:
  filebot:
    image: alandoyle/filebot:latest
    container_name: filebot
    restart: unless-stopped
    init: true
    ports:
      - 80:8080  # If you want to go filebot through a browser
      - 5900:5900  # If you want to use a VNC client instead of the browser
    volumes:
      - /Storage/Incoming:/media
      - ./data:/data
    environment:
      - RESOLUTION=1600x900 # Change resolution (default: 1366x768)
      # - VNC_PASSWORD=8charpwd
    restart: always
    shm_size: "1gb"
```

---

### Ports

| Port       | Description           |
|------------|-----------------------|
| `8080/tcp` | NOVNC HTTP Port       |
| `5900/tcp` | VNC Port              |

---

### Volumes

| Path     | Description                            |
|----------|----------------------------------------|
| `/data`  | path for Filebot configuration files   |
| `/media` | path for Filebot media files           |

### Contributions
Contributions are welcome! Feel free to submit issues or pull requests to improve this project.