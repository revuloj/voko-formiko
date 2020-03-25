#!/bin/bash

from=$1

git show --name-only --oneline --diff-filter=D ${from}.. -- revo \
  | grep -E "^revo/[^ /]+\.xml$" | sed 's/^revo\///g' | sort | uniq

