#!/bin/bash

if [ "$1" == "beta" ]
then
   DRV_VERSION="4.3.22-beta"
else
   DRV_VERSION="4.3.20"
fi

sudo dnf -y install dkms kernel kernel-devel

echo "==============[ Installing Driver $DRV_NAME ($DRV_VERSION) ]=============="
DRV_NAME=rtl8812AU
DRV_INSTALL_DIR="/var/lib/rtl8812AU-driver-${DRV_VERSION}
sudo git clone https://github.com/diederikdehaas/rtl8812AU/ ${DRV_INSTALL_DIR} --branch driver-${DRV_VERSION} 
cd ${DRV_INSTALL_DIR}
sudo mkdir /usr/src/${DRV_NAME}-${DRV_VERSION}
sudo git archive driver-${DRV_VERSION} | sudo tar -x -C /usr/src/${DRV_NAME}-${DRV_VERSION}
sudo dkms add -m ${DRV_NAME} -v ${DRV_VERSION}
sudo dkms build -m ${DRV_NAME} -v ${DRV_VERSION}
sudo dkms install -m ${DRV_NAME} -v ${DRV_VERSION}
sudo dkms status | grep ${DRV_NAME}
sudo modinfo ${DRV_NAME}
