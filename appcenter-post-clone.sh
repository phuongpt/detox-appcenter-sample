#!/usr/bin/env bash

echo "POST CLONE STARTED"

APPLESIMUTILS_VERSION=0.7.6

echo "Installing applesimutils..."
mkdir simutils
cd simutils
curl https://raw.githubusercontent.com/wix/homebrew-brew/master/AppleSimulatorUtils-${APPLESIMUTILS_VERSION}.tar.gz -o applesimutils.tar.gz
tar xzvf applesimutils.tar.gz
sh buildForBrew.sh .
cd ..
export PATH=$PATH:./simutils/build/Build/Products/Release

# echo "Installing correct node version..."
# export HOMEBREW_NO_AUTO_UPDATE=1
# brew uninstall node@6
# brew install node@8
# brew link node@8 --force --overwrite

echo "Identifying selected node version..."
node --version

echo "Installing detox cli..."
npm install -g detox-cli

echo "Installing dependencies for detox tests..."
npm install

echo "Building the project for Detox tests..."
detox build --configuration ios.sim.release

echo "Executing Detox tests..."
detox test --configuration ios.sim.release --cleanup

echo "POST CLONE COMPLETED"
