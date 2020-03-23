# Dockerized EZ-Platform

Create the file auth.json in ./architecture/install-files/ directory.
Put the following json with your Github key token:
```json
{
    "github-oauth": {
        "github.com": "yourGithubKey"
    }
}
```

TODO:  
Créer et utiliser un script "entrypoint.sh" qui effectuera les commandes suivantes:

```bash
#!/bin/sh

docker-compose up -d
docker-compose exec php composer install
# Do the following command only if the .first-install.flag flag is present
# and then remove it
docker-compose exec php composer ezplatform-install
# Vérifier avec un serveur web s'il est nécessaire de changer l'owner des fichiers
# chown -R www-data:www-data .
php-fpm --nodaemonize
```