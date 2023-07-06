#!/usr/bin/env bash

# checking coding style

REQUIRED_TOOLS=(
  hugo
  export
)

for TOOL in "${REQUIRED_TOOLS[@]}"; do
  if ! command -v "${TOOL}" >/dev/null; then
    echo "${TOOL} is required... "
    exit 1
  fi
done

FILE=.env
if [ -f "$FILE" ]; then
  set -a
  source "${FILE}"
  set +a
fi

for FILE in bin/tools/*; do
  set -a
  source "${FILE}"
  set +a
done

grep --color=auto -irnoE "\{\{\-\ \/\*\ TODO.*|- TODO.*" layouts/
