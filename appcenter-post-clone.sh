#!/usr/bin/env bash

echo "POST CLONE STARTED"

APPLESIMUTILS_VERSION=0.7.2

echo "Installing applesimutils... "
echo https://github.com/wix/AppleSimulatorUtils/archive/${APPLESIMUTILS_VERSION}.tar.gz
mkdir simutils
cd simutils
curl -L https://github.com/wix/AppleSimulatorUtils/archive/${APPLESIMUTILS_VERSION}.tar.gz -o applesimutils.tar.gz
tar xzvf applesimutils.tar.gz
sh buildForBrew.sh .
cd ..

export PATH=$PATH:./simutils/build/Build/Products/Release

echo "Installing NVM..."
brew install nvm
source $(brew --prefix nvm)/nvm.sh

echo "Installing v8.5..."
nvm install v8.5.0
nvm use --delete-prefix v8.5.0
nvm alias default v8.5.0

echo "Identifying selected node version..."
node --version

echo "Installing detox cli..."
yarn add -g detox-cli

echo "Installing dependencies for detox tests..."
yarn

echo "Update pod"
cd ios  
pod install
cd ..

echo "Building the project for Detox tests..."
detox build --configuration ios.sim.release

echo "Executing Detox tests..."
detox test --configuration ios.sim.release --cleanup

echo "POST CLONE COMPLETED"
