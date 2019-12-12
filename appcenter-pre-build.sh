#!/usr/bin/env bash

echo "PRE BUILD STARTED"

echo "iOS: Building the project for Detox tests..."
yarn detox build --configuration ios.sim.release

echo "iOS: Cleaning cache for Detox tests..."
detox clean-framework-cache && detox build-framework-cache

echo "iOS: Executing Detox tests..."
yarn detox test --configuration ios.sim.release --cleanup

echo "PRE BUILD COMPLETED"
