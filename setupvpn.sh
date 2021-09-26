#!/bin/bash

echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.4.list
echo "deb http://repo.pritunl.com/stable/apt xenial main" > /etc/apt/sources.list.d/pritunl.list

apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 0C49F3730359A14518585931BC711F9BA15703C6
apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A

apt-get --assume-yes update
apt-get --assume-yes upgrade

apt-get --assume-yes install mongodb-org
systemctl enable mongod
systemctl start mongod

apt-get --assume-yes install openvpn
apt-get --assume-yes install iptables
systemctl enable iptables
systemctl start iptables

wget https://repo.pritunl.com/stable/apt/pool/main/p/pritunl/pritunl_1.29.2664.67-0ubuntu1~bionic_amd64.deb
apt-get --assume-yes install -f ./pritunl_1.29.2664.67-0ubuntu1~bionic_amd64.deb
systemctl start pritunl
systemctl enable pritunl
