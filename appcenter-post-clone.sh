#!/usr/bin/env bash

echo "POST CLONE STARTED"

APPLESIMUTILS_VERSION=0.7.6

echo "Installing applesimutils..."
mkdir simutils
cd simutils
curl https://github.com/wix/AppleSimulatorUtils/archive/${APPLESIMUTILS_VERSION}.tar.gz -o applesimutils.tar.gz
tar xzvf applesimutils.tar.gz
sh buildForBrew.sh .
cd ..

echo "Getting simulators..."
applesimutils --list

export PATH=$PATH:./simutils/build/Build/Products/Release

echo "Installing NVM..."
brew install nvm
source $(brew --prefix nvm)/nvm.sh

echo "Installing v10.15.1..."
nvm install v10.15.1
nvm use --delete-prefix v10.15.1
nvm alias default v10.15.1

echo "Identifying selected node version..."
node --version

echo "Installing detox cli..."
npm install -g detox-cli

echo "Installing dependencies for detox tests..."
npm install

echo "Update pod"
cd ios  
pod install
cd ..

echo "Building the project for Detox tests..."
detox build --configuration ios.sim.release

echo "Executing Detox tests..."
detox test --configuration ios.sim.release --cleanup

echo "POST CLONE COMPLETED"
