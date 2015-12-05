# Docker Container for OpenBCI

### Command to start
#### use `/dev/ttyACM0` or whatever OpenBCI name is for you
`sudo docker run --device=/dev/ttyACM0:/dev/ttyACM0 -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY -it --rm --name processing jnaulty/processing`

###Getting it up on Mac:
Thanks to help from [others](https://github.com/docker/docker/issues/8710) 

```
brew install socat
brew cask install xquartz
open -a XQuartz

socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"
# in another window
docker run -e DISPLAY=192.168.59.3:0 jess/geary
```

