#!/bin/sh
# Script will build php-driver deb artifact

echo "Enter tag version to build"

read TAG_VERSION

echo "Building php-driver from TAG $TAG_VERSION"

LIB_UV_LOCATION="https://downloads.datastax.com/cpp-driver/ubuntu/14.04/dependencies/libuv/v1.8.0/libuv_1.8.0-1_amd64.deb"

LIB_UV_DEV_LOCATION="https://downloads.datastax.com/cpp-driver/ubuntu/14.04/dependencies/libuv/v1.8.0/libuv-dev_1.8.0-1_amd64.deb"

CPP_DRIVER_LOCATION="http://downloads.datastax.com/cpp-driver/ubuntu/14.04/cassandra/v2.5.0/cassandra-cpp-driver_2.5.0-1_amd64.deb"

CPP_DEV_DRIVER_LOCATION="http://downloads.datastax.com/cpp-driver/ubuntu/14.04/cassandra/v2.5.0/cassandra-cpp-driver-dev_2.5.0-1_amd64.deb"

wget $LIB_UV_LOCATION $LIB_UV_DEV_LOCATION $CPP_DRIVER_LOCATION $CPP_DEV_DRIVER_LOCATION

sudo add-apt-repository ppa:ondrej/php -y

sudo apt-get update

sudo apt-get -f install -y

sudo apt-get install -y git debhelper devscripts liblist-moreutils-perl xml2 dh-php php-all-dev pkg-config libgmp-dev libpcre3-dev g++ make cmake libssl-dev openssl

sudo dpkg -i libuv_1.8.0-1_amd64.deb libuv-dev_1.8.0-1_amd64.deb cassandra-cpp-driver_2.5.0-1_amd64.deb cassandra-cpp-driver-dev_2.5.0-1_amd64.deb

git clone https://github.com/datastax/php-driver.git

cd php-driver/

git checkout packaging

cp -R ext/packaging ../temp

git checkout $TAG_VERSION
 
cp -R ../temp ext/packaging

cd ext/packaging/

chmod 777 build_deb.sh

./build_deb.sh

