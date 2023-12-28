#!/bin/bash
sudo mkdir /cbdata

#sudo mkfs -t ext4 /dev/xvdh

sudo /dev/xvdh1 /cbdata ext4 defaults 0 0 >> /etc/fstab
sudo mount -a