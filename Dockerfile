FROM prestashop/prestashop:latest

# Force MySQL CLI tools (mysqladmin ping) to use SSL mode for Aiven
RUN mkdir -p /etc/mysql/conf.d/ && \
    echo "[client]" > /etc/mysql/conf.d/aiven-ssl.cnf && \
    echo "ssl-mode=REQUIRED" >> /etc/mysql/conf.d/aiven-ssl.cnf

# Enable internal PrestaShop database SSL
ENV DB_USE_SSL=1
