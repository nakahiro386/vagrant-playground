#!/usr/bin/env bash
set -e

mitamae_version='1.9.6'
mitamae_bin_name="mitamae-${mitamae_version}"
mitamae_path="./bin/${mitamae_bin_name}"

if [ ! -f "${mitamae_path}" ]; then
    wget -q -O "${mitamae_path}" https://github.com/itamae-kitchen/mitamae/releases/download/v${version}/mitamae-x86_64-linux
    chmod +x "${mitamae_path}"
fi

sudo ${mitamae_path} local $@ recipe.rb

# ${mitamae_path} local $@ recipe/install_anyenv.rb
