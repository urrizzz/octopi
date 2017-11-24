FROM ubuntu:latest
EXPOSE 5000
LABEL maintainer "yuri.dubovitsky@gmail.com"

RUN cd /lib/udev/rules.d && echo "ACTION==\"add\", KERNEL==\"ttyACM0\", MODE=\"0660\", GROUP=\"dialout\"" > octopi.rules

#install ffmpeg
# ffmpeg
RUN apt-get update
RUN apt-get install -y ffmpeg

#install Cura
WORKDIR /
RUN apt-get -y install gcc-4.7 g++-4.7 git build-essential
RUN cd tmp
RUN git clone https://github.com/Ultimaker/CuraEngine -b 15.04.6
WORKDIR CuraEngine
ENV VERSION 15.04.6
RUN make
RUN mkdir /opt/cura/
RUN mv -f ./build/* /opt/cura/
WORKDIR /
RUN rm -Rf /CuraEngine

#Create an octoprint user
RUN mkdir /opt/octoprint
WORKDIR /opt/octoprint
RUN useradd -ms /bin/bash octoprint && adduser octoprint dialout
RUN chown octoprint:octoprint /opt/octoprint
USER octoprint

#This fixes issues with the volume command setting wrong permissions
RUN mkdir /home/octoprint/.octoprint

#Install Octoprint
USER root
RUN apt-get install -y apt-utils python-pip python-dev python-setuptools python-virtualenv libyaml-dev build-essential unzip
USER octoprint
RUN git clone --branch master https://github.com/foosel/OctoPrint.git /opt/octoprint
RUN virtualenv venv
RUN ./venv/bin/python setup.py install

VOLUME /home/octoprint/.octoprint

CMD ["/opt/octoprint/venv/bin/octoprint", "serve"]
