#!/usr/bin/env bash

set -e

source dev-container-features-test-lib

check "serf --version" serf --version

reportResults
