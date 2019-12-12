#!/usr/bin/env bash

echo "POST BUILD STARTED"

git diff > xxx
cat xxx

echo "iOS: Executing Detox tests..."
yarn detox test --configuration ios.sim.release --cleanup

echo "POST BUILD COMPLETED"
