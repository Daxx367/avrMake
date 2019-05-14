#!/bin/bash

#Requires you to install gnu screen, there may be better options depending if you are on OSX or a BSD operating system.

#Press ctr+a then k to "kill" current screen and exit.

#Serial port to connect to (usually USB0).
port=/dev/ttyUSB0

#Bauld rate (19200 for this assignment).
bauld_rate=19200

screen $port $bauld_rate
