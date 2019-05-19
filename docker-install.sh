#!/bin/bash
if ! command -v docker-compose > /dev/null; then
  echo "ERROR: Could not find docker-compose. Make sure you have it installed before continuing. How to install: https://docs.docker.com/compose/install/" > /dev/stderr
  exit
fi

set -ex

cp trunk_player/settings_local.py.docker trunk_player/settings_local.py
docker-compose build
docker-compose up -d nginx postgres redis
echo "Waiting 30 seconds for Redis and Postgres to boot up for the first time..."
sleep 30
docker-compose up -d channelserver channelworker addtransmissionworker
docker-compose exec channelworker bash -c "./manage.py collectstatic --noinput"
docker-compose exec channelworker bash -c "./manage.py migrate"
docker-compose exec channelworker bash -c "./manage.py createsuperuser"
echo
echo "Trunk-Player should now be installed. Open it at http://localhost/"
