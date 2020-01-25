#!/bin/bash -e


#SETUP GPS

on_chroot << EOG

apt-get install -y gpsd gpsd-clients python-gps
apt-get install -y ntp

EOG
