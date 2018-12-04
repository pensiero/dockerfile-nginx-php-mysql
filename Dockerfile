FROM pensiero/nginx-php

# Labels
LABEL maintainer="oscar.fanelli@gmail.com"

# Update, upgrade and install extra PHP modules
RUN apt update -q && apt upgrade -yqq && \
    docker-php-ext-install -j$(nproc) \
        mysqli \
        pdo_mysql