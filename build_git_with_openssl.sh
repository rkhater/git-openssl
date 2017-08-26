#!/bin/bash
# gnutls package. It's working weird behind a proxy. But openssl is working fine even in weak network. So workaround is that we should compile git with# openssl.
# -------------------------------------------------------------------------
# Version 1.0 (June 11th 2014)
# -------------------------------------------------------------------------
# Copyright (c) 2012 Ramy Khater <ramy.m.khater@gmail.com>
# This script is licensed under GNU GPL version 2.0 or above
# -------------------------------------------------------------------------

sudo apt-get install build-essential fakeroot dpkg-dev
sudo rm -fr ~/.git-openssl
mkdir ~/.git-openssl
cd ~/.git-openssl
sudo apt-get source git
sudo apt-get build-dep git
sudo apt-get install libcurl4-openssl-dev
sudo dpkg-source -x git_*.dsc
cd git-*

sleep 5
echo "--> replace all instances of libcurl4-gnutls-dev with libcurl4-openssl-dev in debian/control."
sudo sed -i 's/libcurl4-gnutls-dev/libcurl4-openssl-dev/g' debian/control
sudo dpkg-buildpackage -rfakeroot -b

sudo dpkg -i git_*amd64.deb
