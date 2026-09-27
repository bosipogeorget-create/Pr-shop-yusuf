FROM prestashop/prestashop:latest

# 1. Force Apache to use only mpm_prefork to prevent Railway crash loop
RUN a2dismod mpm_event mpm_worker || true \
 && a2enmod mpm_prefork

# 2. Increase PHP limits for extraction
RUN echo "max_execution_time = 300" > /usr/local/etc/php/conf.d/limits.ini \
 && echo "memory_limit = 512M" >> /usr/local/etc/php/conf.d/limits.ini \
 && echo "max_input_time = 300" >> /usr/local/etc/php/conf.d/limits.ini

# 3. Patch MyISAM to InnoDB globally for Aiven MySQL
RUN find /var/www/html -type f -name "*.php" -exec sed -i "s/ENGINE=MyISAM/ENGINE=InnoDB/g" {} + || true
RUN find /var/www/html -type f -name "*.php" -exec sed -i "s/'MyISAM'/'InnoDB'/g" {} + || true
RUN find /var/www/html -type f -name "*.php" -exec sed -i "s/\"MyISAM\"/\"InnoDB\"/g" {} + || true

# 4. Create the unlock script
RUN echo '<?php system("rm -rf install/"); echo "Install folder deleted! You can now access your store."; ?>' > /var/www/html/unlock.php
