# Arguments declared before the FROM instruction can only be used in the first FROM instruction.
# For more informations, see https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact
ARG version
ARG os

FROM php:${version}-fpm-${os}

ARG docker_php_ext
ARG classic_php_ext
ARG package_manager
ARG extension_package

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN ${package_manager} update -yq \
    && ${package_manager} install curl gnupg -yq \
    && curl -sL https://deb.nodesource.com/setup_10.x | bash \
    && ${package_manager} install nodejs -yq \
    && ${package_manager} install -y unzip \
    && ${package_manager} install -y git \
    && ${package_manager} clean -y

RUN npm install -g yarn

# This script facilitates the PHP extensions installation.
# For more, details, see https://github.com/mlocati/docker-php-extension-installer
ADD https://raw.githubusercontent.com/mlocati/docker-php-extension-installer/master/install-php-extensions /usr/local/bin/

RUN chmod uga+x /usr/local/bin/install-php-extensions && sync && \
    install-php-extensions ${docker_php_ext}

EXPOSE 9000

WORKDIR /var/www/ez-platform

ENTRYPOINT php-fpm --nodaemonize