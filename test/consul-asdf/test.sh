#!/usr/bin/env bash

set -e

source dev-container-features-test-lib

check "consul --version" consul --version

reportResults
