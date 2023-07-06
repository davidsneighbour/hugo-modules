#!/usr/bin/env bash

# declare path to this script
SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 || exit ; pwd -P )"

# send all tags to remote
git push --follow-tags origin main
git push --tags
