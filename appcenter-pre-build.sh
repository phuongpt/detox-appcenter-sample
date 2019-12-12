#!/usr/bin/env bash

echo "PRE BUILD STARTED"

echo "iOS: Building the project for Detox tests..."
npx detox build --configuration ios.sim.release

echo "iOS: Cleaning cache for Detox tests..."
npx clean-framework-cache && detox build-framework-cache

echo "iOS: Executing Detox tests..."
npx detox test --configuration ios.sim.release --cleanup

echo "PRE BUILD COMPLETED"
