#!/usr/bin/env bash

echo "PRE BUILD STARTED"

echo "iOS: Executing Detox tests..."
yarn detox test --configuration ios.sim.release --cleanup

echo "PRE BUILD COMPLETED"
