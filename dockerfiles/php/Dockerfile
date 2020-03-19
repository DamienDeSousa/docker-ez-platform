# Arguments declared before the FROM instruction can only be used in the first FROM instruction.
# For more informations, see https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact
ARG version
ARG os

FROM php:${version}-${os}

ARG docker_php_ext
ARG docker_php_external_extension
ARG classic_php_extension
ARG package_manager
ARG extension_package

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN ${package_manager} update -yq \
    && ${package_manager} install curl gnupg -yq \
    && curl -sL https://deb.nodesource.com/setup_10.x | bash \
    && ${package_manager} install nodejs -yq \
    && ${package_manager} clean -y

ADD https://raw.githubusercontent.com/mlocati/docker-php-extension-installer/master/install-php-extensions /usr/local/bin/

RUN chmod uga+x /usr/local/bin/install-php-extensions && sync && \
    install-php-extensions ${docker_php_ext}
# RUN ${package_manager} install ${docker_php_ext}
# RUN docker-php-ext-install ${docker_php_ext} 
#     && docker-php-ext-install ext-name ${docker_php_external_extension}

# RUN composer create-project --keep-vcs ezsystems/ezplatform ./my-project
# RUN cd my-project && composer ezplatform-install && chown -R www-data:www-data .

# docker build -t php-args-test --build-arg version=7.3.15 --build-arg os=buster --build-arg ext="xml intl curl" --build-arg package_manager=apt-get .
# don't work     

# Possible values for docker-php-ext-install:
# bcmath bz2 calendar ctype curl dba dom enchant exif fileinfo filter ftp gd gettext gmp hash iconv imap interbase intl json 
# ldap mbstring mysqli oci8 odbc opcache pcntl pdo pdo_dblib pdo_firebird pdo_mysql pdo_oci pdo_odbc pdo_pgsql pdo_sqlite 
# pgsql phar posix pspell readline recode reflection session shmop simplexml snmp soap sockets sodium spl standard sysvmsg 
# sysvsem sysvshm tidy tokenizer wddx xml xmlreader xmlrpc xmlwriter xsl zend_test zip