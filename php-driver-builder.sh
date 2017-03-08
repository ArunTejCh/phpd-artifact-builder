#!/bin/sh
# Script will build php-driver deb artifact

#############
LIB_UV_LOCATION="https://downloads.datastax.com/cpp-driver/ubuntu/14.04/dependencies/libuv/v1.8.0/libuv_1.8.0-1_amd64.deb"

LIB_UV_DEV_LOCATION="https://downloads.datastax.com/cpp-driver/ubuntu/14.04/dependencies/libuv/v1.8.0/libuv-dev_1.8.0-1_amd64.deb"

CPP_DRIVER_LOCATION="http://downloads.datastax.com/cpp-driver/ubuntu/14.04/cassandra/v2.5.0/cassandra-cpp-driver_2.5.0-1_amd64.deb"

CPP_DEV_DRIVER_LOCATION="http://downloads.datastax.com/cpp-driver/ubuntu/14.04/cassandra/v2.5.0/cassandra-cpp-driver-dev_2.5.0-1_amd64.deb"

LIB_UV="libuv_1.8.0-1_amd64.deb"

LIB_UV_DEV="libuv-dev_1.8.0-1_amd64.deb"

CPP_DRIVER="cassandra-cpp-driver_2.5.0-1_amd64.deb"

CPP_DEV_DRIVER="cassandra-cpp-driver-dev_2.5.0-1_amd64.deb"

DEPENDENCY_LIST="git debhelper devscripts liblist-moreutils-perl xml2 dh-php php-all-dev pkg-config libgmp-dev libpcre3-dev g++ make cmake libssl-dev openssl"

PHP_DRIVER_REPO="https://github.com/datastax/php-driver.git"

REPO_DIR="php-driver"

ARTIFACT_TAG="packaging"

BUILD_SCRIPT_DIR="ext/packaging"

TEMP_DIR="temp"

BUILD_SCRIPT="build_deb.sh"

BUILD_DIR="build"

PHP_REPO_PPA="ppa:ondrej/php"

############

echo "Enter tag version to build"

read TAG_VERSION

echo "Building php-driver from TAG $TAG_VERSION"

wget $LIB_UV_LOCATION $LIB_UV_DEV_LOCATION $CPP_DRIVER_LOCATION $CPP_DEV_DRIVER_LOCATION

sudo add-apt-repository $PHP_REPO_PPA -y

sudo apt-get update

sudo apt-get -f install -y

sudo apt-get install -y $DEPENDENCY_LIST

sudo dpkg -i $LIB_UV $LIB_UV_DEV $CPP_DRIVER $CPP_DEV_DRIVER

git clone $PHP_DRIVER_REPO

cd $REPO_DIR

git checkout $ARTIFACT_TAG

cp -R $BUILD_SCRIPT_DIR ../$TEMP_DIR

git checkout $TAG_VERSION
 
cp -R ../$TEMP_DIR $BUILD_SCRIPT_DIR

cd $BUILD_SCRIPT_DIR

chmod 777 $BUILD_SCRIPT

./$BUILD_SCRIPT

mv $BUILD_DIR/  ../../../

cd ../../../

#cleanup code
rm $LIB_UV $LIB_UV_DEV $CPP_DRIVER $CPP_DEV_DRIVER

rm -rf $TEMP_DIR $REPO_DIR

