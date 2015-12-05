# Docker Container for OpenBCI

### Command to start
#### use `/dev/ttyACM0` or whatever OpenBCI name is for you
`sudo docker run --device=/dev/ttyACM0:/dev/ttyACM0 -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY -it --rm --name processing jnaulty/processing`

