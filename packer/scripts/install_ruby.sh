#!/bin/sh
apt update
sleep 5
killall apt apt-get
apt-get install -y ruby-full ruby-bundler build-essential
