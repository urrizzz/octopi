# octopi

OctoPrint container for Raspberry Pi

Includes:

OctoPrint 1.3.5
OctoPrint checkout folder (for updates): /home/octoprint/OctoPrint
CuraEngine 15.04.5 (Path: /opt/cura/CuraEngine)
ffmpeg 2.8.11 (Path: /usr/bin/ffmpeg)

Start container:
docker run -p 5000:5000 --name=octopi --restart=always -d --device /dev/ttyACM0 urrizzz/octopi:latest

Octorpint access:
http://localhost:5000

Known bug:
Automatic detection of Serial Port and Baudrate might not work (it doesn't work for me). I have to manually select the port (/dev/ACM0) and baudrate (115200) and TRY TO CONNECT MULTIPLE TIMES! Usually it gives me a timeout on a first or second try BUT eventually it connects. After the connection is made it works fine. It may be related to specific printer.
