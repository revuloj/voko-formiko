#!/bin/bash

from=$1

git show --name-only --oneline --diff-filter=AM ${from}.. -- revo \
  | grep -E "^revo/[^ /]+\.xml$" | sed 's/^revo\///g' | sort | uniq

