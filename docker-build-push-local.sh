#!/bin/bash

docker build -t voko-formiko .
docker tag voko-formiko registry.local:5000/voko-formiko
docker push registry.local:5000/voko-formiko