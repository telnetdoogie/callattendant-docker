# callattendant-docker

This is a dockerized version of [@thess](https://github.com/thess)'s [CallAttendant](https://github.com/thess/callattendant/).

Document updates to come.

```
docker run --rm -it --device=/dev/ttyACM0 \
    -v /volume1/docker/callattendant-docker/config:/app/config \
    -p 9991:5000 \
    telnetdoogie/callattendant-docker:latest
```
