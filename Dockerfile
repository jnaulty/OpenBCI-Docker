# if user not in docker group then change xhost for root access
# xhost local:root
# sudo docker run \
#    --device=/dev/ttyACM0:/dev/ttyACM0 \  #or whatever OpenBCI name is for you
#    -v /tmp/.X11-unix:/tmp/.X11-unix \
#    -e DISPLAY=unix$DISPLAY -it \
#    --rm --name processing jnaulty/processing

FROM ubuntu

MAINTAINER John Naulty Jr. <jnaulty@gmail.com>

RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  apt-get install -y software-properties-common  && \
  add-apt-repository -y ppa:webupd8team/java

RUN apt-get update && apt-get install -y \
    git  \
    curl \
    default-jre \
    libcanberra-gtk3-module \
    libgtk2.0-0 \
    libx11-6 \
    && rm -rf /var/lib/apt/lists/*    

RUN mkdir /home/processing
WORKDIR /home/processing

RUN curl -sSL http://download.processing.org/processing-2.2.1-linux64.tgz -o /home/processing/processing-2.2.1-linux64.tgz && \
     tar -xzf processing-2.2.1-linux64.tgz 

RUN ln -s /home/processing/processing-2.2.1/processing /usr/bin/processing
RUN ln -s /home/processing/processing-2.2.1/processing-java /usr/bin/processing-java

RUN mkdir -p /root/sketchbook/libraries

RUN git clone https://github.com/OpenBCI/OpenBCI_Processing.git && \
    mv OpenBCI_Processing/libraries/* /root/sketchbook/libraries/ && \
    mv OpenBCI_Processing /root/sketchbook/

COPY pstart /home/processing


#ENTRYPOINT ["processing"]
#CMD ["processing-java --run --sketch=/root/sketchbook/OpenBCI_Processing/OpenBCI_GUI/ --output=/root/sketchbook/OpenBCI_Processing/OpenBCI_GUI/output --force"]
CMD ["./pstart"]
