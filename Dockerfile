FROM prestashop/prestashop:latest

# Disable conflicting MPMs and enforce prefork
RUN a2dismod mpm_event mpm_worker || true \
    && a2enmod mpm_prefork
