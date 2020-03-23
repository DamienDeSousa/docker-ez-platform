#!/bin/sh

docker-compose up -d
docker-compose exec php composer install
docker-compose exec php composer ezplatform-install
# chown -R www-data:www-data .