FROM php:8.1-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    curl \
    gnupg \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    libicu-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql mbstring zip gd intl

# Install Node.js (LTS version)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g npm

# Enable Apache modules
RUN a2enmod rewrite

# Silence Apache ServerName warning
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Clone Omeka S
RUN git clone --depth=1 --branch v4.1.1 https://github.com/omeka/omeka-s.git /var/www/html/omeka-s

# Build frontend assets
WORKDIR /var/www/html/omeka-s
RUN npm install && npx gulp init

# Set correct Apache DocumentRoot
RUN sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/omeka-s|g' /etc/apache2/sites-available/000-default.conf

# Fix permissions
RUN chown -R www-data:www-data /var/www/html/omeka-s && \
    find . -type f -exec chmod 644 {} \; && \
    find . -type d -exec chmod 755 {} \;

EXPOSE 80

