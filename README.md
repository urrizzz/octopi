# octopi

OctoPrint container based on Ubuntu.

Includes:

OctoPrint 1.3.5
CuraEngine 15.04.5 (Path: CuraEngine/build/CuraEngine)
ffmpeg 2.8.11 (Path: usr/bin/ffmpeg)

Run:
docker run -p 5000:5000 --name=octopi --restart=always -d -v /dev/ttyACM0:/dev/ttyACM0 urrizzz/octopi
