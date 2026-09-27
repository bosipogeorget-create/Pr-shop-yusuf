FROM prestashop/prestashop:latest

# Remove all MPM module symlinks to guarantee zero active MPMs, then enable prefork
RUN rm -f /etc/apache2/mods-enabled/mpm_*.load \
    && rm -f /etc/apache2/mods-enabled/mpm_*.conf \
    && a2enmod mpm_prefork
