#!/bin/bash

set -e

chown -R www-data:www-data /var/www/html

mkdir -p /var/www/html/cache

exec apache2-foreground
