FROM docker.io/prestashop/prestashop:latest

# 1. Resolve Apache MPM Conflict
RUN a2dismod mpm_event mpm_worker && a2enmod mpm_prefork

# 2. Configure PHP Limits
RUN echo "max_execution_time = 300" > /usr/local/etc/php/conf.d/limits.ini \
    && echo "memory_limit = 512M" >> /usr/local/etc/php/conf.d/limits.ini \
    && echo "max_input_time = 300" >> /usr/local/etc/php/conf.d/limits.ini

# 3. Replace MyISAM with InnoDB
RUN find /var/www/html -type f -name "*.php" -exec sed -i "s/ENGINE=MyISAM/ENGINE=InnoDB/g" {} + || true \
    && find /var/www/html -type f -name "*.php" -exec sed -i "s/'MyISAM'/'InnoDB'/g" {} + || true \
    && find /var/www/html -type f -name "*.php" -exec sed -i "s/\"MyISAM\"/\"InnoDB\"/g" {} + || true

# 4. Create Install Unlocker
RUN echo '<?php system("rm -rf install/"); echo "Install folder deleted! You can now access your store."; ?>' > /var/www/html/unlock.php
Set up MySQL client SSL defaults inside the container
RUN echo "[client]" >> /etc/mysql/conf.d/aiven-ssl.cnf && \
    echo "ssl-mode=REQUIRED" >> /etc/mysql/conf.d/aiven-ssl.cnf

# Enable SSL for PrestaShop database setup
ENV DB_USE_SSL=1
