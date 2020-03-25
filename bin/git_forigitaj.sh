#!/bin/bash

from=$1
path=$2

git show --name-only --oneline --diff-filter=D ${from}.. -- ${path} \
  | grep -E "^revo/[^ /]+\.xml$" | sed 's/^revo\///g' | sort | uniq

