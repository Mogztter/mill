#!/usr/bin/env bash

set -eux

# Starting from scratch...
git clean -xdf

# First build

mill -i all __.publishLocal release

mv out/release/dest/mill ~/mill-1

# Clean up

git clean -xdf && rm -fR ~/.mill

# Differentiate first and second builds

echo "Build 2" > info.txt && git add info.txt && git commit -m "Add info.txt"

# Second build

~/mill-1 -i all __.publishLocal release

mv out/release/dest/mill ~/mill-2

# Clean up

git clean -xdf && rm -fR ~/.mill

# Use second build to run tests using Mill

~/mill-2 -i integration.test "mill.integration.forked.{AcyclicTests,UpickleTests,PlayJsonTests}"
