#!/bin/bash

#Press ctr+a then k to "kill" current screen and exit.

#Serial port to connect to (usually USB0).
port=/dev/ttyUSB0

#Bauld rate (19200 for this assignment).
bauld_rate=19200

screen $port $bauld_rate
