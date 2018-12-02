FROM php:7.2-fpm

# Labels
LABEL maintainer="oscar.fanelli@gmail.com"

# Base services
RUN apt update -q && apt install -yqq \
    gnupg

# Yarn (package manager)
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb http://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# NVM (node version manager)
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash
RUN bash -c 'source $HOME/.nvm/nvm.sh && nvm install 8.9.0'

# Update, upgrade and install extra PHP modules
RUN apt update -q && apt upgrade -yqq && apt install -yqq \
    git \
    libmcrypt-dev \
    libssl-dev \
    yarn \
    zip \
    zlib1g-dev libicu-dev g++ && \
    docker-php-ext-install -j$(nproc) \
        bcmath \
        intl

# Composer installer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Update node executable path
ENV PATH=$PATH:/root/.nvm/versions/node/v8.9.0/bin

# Workdir
WORKDIR /usr/share/nginx/