FROM php:8.1-apache

# 1. Install system dependencies and PHP extensions strictly required by PrestaShop 8
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    libicu-dev \
    libonig-dev \
    libxml2-dev \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd zip intl pdo_mysql mbstring simplexml

# 2. Enable Apache rewrite module (critical for PrestaShop friendly URLs and API)
RUN a2enmod rewrite

# 3. Copy your GitHub repository files into the container's web root
COPY . /var/www/html/

# 4. Grant strict but accessible ownership to the Apache user (fixes write-permission errors during install)
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# 5. Expose the standard web port for Railway's routing
EXPOSE 80
