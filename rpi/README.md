# Raspberry Pi build

This is the raspberry pi build of the same project. Try to keep it as similar as possible to the parent project.

## Building

To build the image on raspberry pi, from the root folder:
```
docker build -t node-red -f rpi-Dockerfile .
```


# Z-Wave

If you are using the Razberry controller, then it maps to /dev/ttyAMA0. It needs to be relinked to /dev/ttyUSB0, so run it like this:

```
docker run -p 1880:1880 --device /dev/ttyAMA0:/dev/ttyUSB0 -d node-red
```
