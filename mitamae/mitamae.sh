#!/usr/bin/env bash
set -e

script_dir=$(cd "$(dirname $0)" && pwd)
cd "$script_dir"

mitamae_version='1.11.7'
mitamae_bin="${script_dir}/bin/mitamae-x86_64-linux-${mitamae_version}"
mitamae_sha256='513dc86f05ffe5d1fd85d835169aa414c8a32b9ac4190f62605839f38a0c0be5'
mitamae_sha256_file="${script_dir}/bin/mitamae.sha256"

if [ ! -e "${mitamae_bin}" ]; then
    wget -q -O "${mitamae_bin}" https://github.com/itamae-kitchen/mitamae/releases/download/v${mitamae_version}/mitamae-x86_64-linux
    chmod +x "${mitamae_bin}"
fi
if [ ! -e "${mitamae_sha256_file}" ]; then
    echo "${mitamae_sha256} *${mitamae_bin}" > ${mitamae_sha256_file}
fi

if ! sha256sum --quiet --status -c ${mitamae_sha256_file}; then
    echo "checksum verificatoin failed!"
    exit 1
fi

${mitamae_bin} $@
