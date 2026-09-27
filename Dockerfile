FROM prestashop/prestashop:latest

# Disable both modules individually before enforcing prefork
RUN a2dismod mpm_event || true
RUN a2dismod mpm_worker || true
RUN a2enmod mpm_prefork
