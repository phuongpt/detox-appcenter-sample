#!/usr/bin/env bash

echo "POST CLONE STARTED"

echo "iOS: Installing applesimutils..."
brew tap wix/brew
brew install wix/brew/applesimutils

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
yarn

echo "iOS: Building the project for Detox tests..."
yarn detox build --configuration ios.sim.release

echo "iOS: Cleaning cache for Detox tests..."
detox clean-framework-cache && detox build-framework-cache

echo "iOS: Executing Detox tests..."
yarn detox test --configuration ios.sim.release --cleanup

echo "POST CLONE COMPLETED"
