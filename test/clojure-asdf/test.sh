#!/usr/bin/env bash

set -e

source dev-container-features-test-lib

check "clojure --version" clojure --version

reportResults
