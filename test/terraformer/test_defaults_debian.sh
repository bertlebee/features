#!/usr/bin/env bash

set -e

source dev-container-features-test-lib

check "terraformer version" terraformer version

reportResults
