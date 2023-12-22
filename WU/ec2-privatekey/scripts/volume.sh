#!/bin/bash

mkdir /data

sudo mkfs -t ext4 /dev/xvdh

/dev/xvdh /new_data ext4 defaults 0 0 >> /etc/fstab
mount -a