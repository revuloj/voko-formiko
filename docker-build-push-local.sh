#!/bin/bash

img=voko-formiko

docker build -t $img .
docker tag $img registry.local:5000/$img
docker push registry.local:5000/$img