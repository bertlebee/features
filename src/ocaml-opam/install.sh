#!/usr/bin/env bash

set -e

source ./library_scripts.sh

# nanolayer is a cli utility which keeps container layers as small as possible
# source code: https://github.com/devcontainers-extra/nanolayer
# `ensure_nanolayer` is a bash function that will find any existing nanolayer installations,
# and if missing - will download a temporary copy that automatically get deleted at the end
# of the script
ensure_nanolayer nanolayer_location "v0.5.6"

# Example nanolayer installation via devcontainer-feature
$nanolayer_location \
    install \
    devcontainer-feature \
    "ghcr.io/devcontainers-extra/features/gh-release:1" \
    --option repo='ocaml/opam' --option binaryNames='opam' --option version="latest"


# Initialise opam
if [ "$VERSION" = "latest" ]; then
    su "$_REMOTE_USER" -c "opam init --disable-sandboxing --shell-setup -y"
else
    su "$_REMOTE_USER" -c "opam init --disable-sandboxing --shell-setup -y --compiler=\"$VERSION\""
fi
# Install Platform Tools
su "$_REMOTE_USER" -c "opam install ocaml-lsp-server odoc ocamlformat utop -y"


echo 'Done!'
