FROM prestashop/prestashop:latest

# Install ca-certificates and curl/wget
RUN apt-get update && apt-get install -y ca-certificates wget && rm -rf /lib/apt/lists/*

# Set up MySQL client SSL defaults inside the container
RUN echo "[client]" >> /etc/mysql/conf.d/aiven-ssl.cnf && \
    echo "ssl-mode=REQUIRED" >> /etc/mysql/conf.d/aiven-ssl.cnf

# Enable SSL for PrestaShop database setup
ENV DB_USE_SSL=1
