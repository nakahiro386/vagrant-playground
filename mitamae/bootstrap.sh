#!/usr/bin/env bash
set -e

SCRIPT_DIR=$(cd "$(dirname $0)" && pwd)
sudo "${SCRIPT_DIR}/mitamae.sh" local $@ ${SCRIPT_DIR}/recipes/recipe.rb
