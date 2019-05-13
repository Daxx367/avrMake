#!/bin/bash

# This is only to be run if you have managed to "brick" your 342a, it attempts to fix the fuse settings.
avrdude -p m324pa -P /dev/ttyACM0 -c stk600 -F -U lfuse:w:0xe1:m -U hfuse:w:0xd9:m

