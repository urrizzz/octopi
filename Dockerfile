FROM ubuntu
MAINTAINER yuri.dubovitsky@gmail.com
#octoprint
RUN apt-get update
RUN apt-get install -y apt-utils python-pip python-dev python-setuptools python-virtualenv git libyaml-dev build-essential unzip
RUN /usr/bin/easy_install virtualenv
RUN git clone https://github.com/foosel/OctoPrint.git
RUN virtualenv venv
RUN ./venv/bin/pip install pip --upgrade
WORKDIR /OctoPrint
RUN ../venv/bin/python setup.py install
RUN mkdir ~/.octoprint
#curaengine
WORKDIR /
RUN apt-get -y install gcc-4.7 g++-4.7
RUN git clone https://github.com/Ultimaker/CuraEngine -b 15.04.6
WORKDIR CuraEngine
ENV VERSION 15.04.6
RUN make
WORKDIR /
# ffmpeg
RUN apt-get install -y ffmpeg
#run octoprint
RUN adduser --system octouser && adduser octouser root && usermod -a -G tty octouser && usermod -a -G dialout octouser
USER octouser
ENTRYPOINT ["/venv/bin/octoprint","serve"]
EXPOSE 5000