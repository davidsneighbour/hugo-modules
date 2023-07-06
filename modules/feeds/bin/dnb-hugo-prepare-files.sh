#!/usr/bin/env bash

REQUIRED_TOOLS=(
  node
  export
  trap
)

for TOOL in "${REQUIRED_TOOLS[@]}"; do
  if ! command -v "${TOOL}" >/dev/null; then
    echo "${TOOL} is required... "
    exit 1
  fi
done

trap "{ echo 'Terminated with Ctrl+C'; }" SIGINT

FILE=.env
if [ -f "$FILE" ]; then
  echo "exporting .env"
  set -a
  # shellcheck source=/dev/null
  source "${FILE}"
  set +a
fi

node ./node_modules/replace-between/bin/replace-between.js \
  --source "${TEMPLATEPATH}"/readme/components.md \
  --target README.md \
  --token COMPONENTS

node ./node_modules/replace-between/bin/replace-between.js \
  --source "${TEMPLATEPATH}"/readme/installupdate.md \
  --target README.md \
  --token INSTALLUPDATE

node ./node_modules/replace-between/bin/replace-between.js \
  --source "${TEMPLATEPATH}"/readme/thingstoknow.md \
  --target README.md \
  --token THINGSTOKNOW
