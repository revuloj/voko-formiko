#!/bin/bash

if [[ $(cat /proc/1/cmdline | tr '\0' ' ') = cron* ]]; then
    exit 0
else
    exit 1
fi
