# **CallAttendant-Docker**

This is a dockerized version of [@thess](https://github.com/thess)'s [CallAttendant](https://github.com/thess/callattendant/).

You'll need to know which device is being used as your modem, and will need to add it to `--device` (docker run) or `devices:` (compose).

### First-time Run:

Add / Copy and edit the [`./app.cfg`](./app.cfg) file from this repo to the folder that you'll mount (I used `/volume1/docker/callattendant/config`).
If you don't add this file, a default file will be created in the mounted folder. You'll then need to stop the container to edit the new file in the config folder. 
It's important to mount this folder so that you don't lose your config and DB when image is updated or after destroying/recreating the container.

The container listens on port 5000. Choose any open port to map to the container. This container works well with reverse proxy setups, no additional config needed.

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

### Synology NAS users:

I am using this on a Synology NAS with a **StarTech.com USB 2.0 Fax Modem** that I picked up from Amazon. Should work with other Conexant USB modems. After installing the SynoCommunity Package [USBSerial](https://synocommunity.com/package/synokernel-usbserial) I run the following script on bootup as root (I don't think they're all needed but installed them all anyway based on [MariusHosting's USB Drivers article](https://mariushosting.com/synology-how-to-add-usb-support-on-dsm-7/). Using this USB Modem, my device (as in the compose above) shows up as `/dev/ttyACM0`

```bash
#!/bin/sh

echo "Loading kernel modules"
# ensure kernel modules are loaded
/sbin/modprobe usbserial
/sbin/modprobe ftdi_sio
/sbin/modprobe cdc-acm

echo "Fixing Perms"
# add perms to devices
chmod 777 /dev/ttyACM0
# chmod 777 /dev/ttyUSB0

echo "Done"
```
