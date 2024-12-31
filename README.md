# callattendant-docker

This is a dockerized version of [@thess](https://github.com/thess)'s [CallAttendant](https://github.com/thess/callattendant/).

More document updates to come.

### Docker Run:

```
docker run --rm -it --device=/dev/ttyACM0 \
    -v /volume1/docker/callattendant-docker/config:/app/config \
    -p 9991:5000 \
    telnetdoogie/callattendant-docker:latest
```

### Docker-Compose:

```yml
services:

  callattendant:
    container_name: callattendant
    image: telnetdoogie/callattendant-docker:latest
    devices:
      - /dev/ttyACM0    # add your modem dev path here
    volumes:
      - /volume1/docker/callattendant/config:/app/config:rw
    ports:
      - 8088:5000
    restart: unless-stopped
```
