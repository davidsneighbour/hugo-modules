#!/usr/bin/env bash
set -euo pipefail

# Determine the directory of this script.
CURRENT_DIR=$(dirname "$(realpath "$0")")
# Repository root is three directories up from tests/gohugo/scripts.
REPO_ROOT=$(realpath "$CURRENT_DIR/../../..")

MODULES_DIR="${REPO_ROOT}/modules"
CONFIG_FILE="${REPO_ROOT}/tests/gohugo/config/local/hugo.toml"

if [[ ! -d "$MODULES_DIR" ]]; then
  echo "Error: Modules directory not found at ${MODULES_DIR}" >&2
  exit 1
fi

if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "Error: Config file not found at ${CONFIG_FILE}" >&2
  exit 1
fi

# Build the replacements string by iterating over each directory in MODULES_DIR.
REPLACEMENTS=""
for module in "$MODULES_DIR"/*; do
  if [[ -d "$module" ]]; then
    modname=$(basename "$module")
    entry="github.com/davidsneighbour/hugo-modules/modules/${modname} -> ../../modules/${modname}"
    if [[ -z "$REPLACEMENTS" ]]; then
      REPLACEMENTS="${entry}"
    else
      REPLACEMENTS+=", ${entry}"
    fi
  fi
done

# Update the config file by replacing the line that starts with "replacements ="
# A backup of the original file will be created with a .bak extension.
sed -i.bak "s|^replacements = .*|replacements = '${REPLACEMENTS}'|" "$CONFIG_FILE"

echo "Updated ${CONFIG_FILE} with replacements:"
echo "${REPLACEMENTS}"
