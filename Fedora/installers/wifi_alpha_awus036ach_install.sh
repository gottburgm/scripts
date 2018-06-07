#!/bin/bash

echo "Installing dependencies ..."
sudo sudo dnf install elfutils-libelf-devel

git clone https://github.com/madmantm/rtl8814au /tmp/rtl8814au
cd /tmo/rtl8814au
make RTL8814=1
sudo make  RTL8814=1 install
sudo modprobe 8814au
