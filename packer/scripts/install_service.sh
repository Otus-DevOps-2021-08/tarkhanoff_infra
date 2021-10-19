#!/bin/sh
mv -v /tmp/reddit.service /etc/systemd/system/
systemctl enable reddit
