#!/bin/sh

sudo apt-get install -y git

cd /home/ubuntu
git clone -b monolith https://github.com/express42/reddit.git

cd reddit
bundle install
