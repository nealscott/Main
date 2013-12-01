#!/bin/bash

# diskutil list

diskutil unmount /dev/disk0s4

sudo dd if=/dev/disk0s4 | gzip > ~/BootCamp.iso.gz

diskutil mount /dev/disk0s4

# sudo dd if=/dev/disk0s4 | gzip > /BootCamp.iso.gz