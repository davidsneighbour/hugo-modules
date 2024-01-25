#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 || exit ; pwd -P )"

if test -f "$SCRIPTPATH"/post-titles; then
  while read -r __; do
    postname=${__[0]}           # load the line
    postname=${postname,,}      # lowercase
    postname=${postname// /-}   # replace spaces with dashes

    hugo new posts/${postname}/index.md
  done < "$SCRIPTPATH"/post-titles
fi
