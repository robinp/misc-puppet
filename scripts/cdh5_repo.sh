#!/bin/sh
sudo wget 'http://archive.cloudera.com/cdh5/ubuntu/wheezy/amd64/cdh/cloudera.list' \
    -O /etc/apt/sources.list.d/cloudera.list
sudo apt-get update
wget http://archive.cloudera.com/cdh5/debian/wheezy/amd64/cdh/archive.key -O archive.key
sudo apt-key add archive.key