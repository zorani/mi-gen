#!/bin/bash -e


#SETUP GPS

on_chroot << EOG

apt-get install gpsd gpsd-clients python-gps
apt-get install ntp

EOG
