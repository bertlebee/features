#!/usr/bin/env bash

set -e

source ./library_scripts.sh

# nanolayer is a cli utility which keeps container layers as small as possible
# source code: https://github.com/devcontainers-extra/nanolayer
# `ensure_nanolayer` is a bash function that will find any existing nanolayer installations,
# and if missing - will download a temporary copy that automatically get deleted at the end
# of the script
ensure_nanolayer nanolayer_location "v0.5.6"

# Split packages by comma
IFS=',' read -ra PACKAGE_ARRAY <<<"$PACKAGES"

# Iterate through each package
for package in "${PACKAGE_ARRAY[@]}"; do
    # Use regex to match valid npm package identifier
    # unscoped, unscoped@version, @scoped, @scoped@version
    if [[ $package =~ ^(@?[^@]+?)(@(.+?))?$ ]]; then
        name="${BASH_REMATCH[1]}"
        version="${BASH_REMATCH[3]}"
        # Bash doesn't have non-capturing groups so @version portion can
        # only be made optional inside a group, then a nested group captures
        # the version number itself.
    else
        # Fallback for any invalid package identifiers
        name=$package
        version=""
    fi

    # Install package via npm-package feature
    $nanolayer_location \
        install \
        devcontainer-feature \
        "ghcr.io/devcontainers-extra/features/npm-package:1.0.3" \
        --option package="$name" --option version="$version"

done

echo 'Done!'
