#!/usr/bin/env bash

docker-compose -f docker/docker-compose.yml down
[ -e tmp/pids/server.pid ] && rm tmp/pids/server.pid
rm -fr public/packs/*
docker-compose -f docker/docker-compose.yml up rails sidekiq webpacker
