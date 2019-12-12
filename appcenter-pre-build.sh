#!/usr/bin/env bash

echo "PRE BUILD STARTED"

echo "iOS: Installing applesimutils..."
brew tap wix/brew
brew install wix/brew/applesimutils

echo "Identifying selected node version..."
node --version

echo "Installing detox cli..."
npm install -g detox-cli

echo "iOS: Update pod"
cd ios  
pod install
cd ..

echo "iOS: Building the project for Detox tests..."
npx detox build --configuration ios.sim.release

echo "iOS: Cleaning cache for Detox tests..."
npx clean-framework-cache && detox build-framework-cache

echo "iOS: Executing Detox tests..."
npx detox test --configuration ios.sim.release --cleanup

echo "PRE BUILD COMPLETED"
