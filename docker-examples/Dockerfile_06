FROM node:14.7.0-buster-slim AS apache_for_sugarcrm

ENV http_proxy http://proxy.example.com:8080/
ENV https_proxy https://proxy.example.com:8080/

RUN addgroup --system shared-folder \
 && adduser --system --home /var/cache/shared-folder --group shared-folder --uid 1001

EXPOSE 80/tcp
EXPOSE 443/tcp

ENV NODE_ENV=dev

RUN apt-get -qq update && apt-get -qq install -y --no-install-recommends nano git openssl bash musl curl apache2 apache2-utils systemd && \
 systemctl enable apache2 && npm config set registry http://localhost:5000/repository/repo && \
 npm i -g pm2 serve && mkdir /usr/share/shared-folder

RUN ln -sf /dev/stdout /var/log/apache2/access.log && \
 ln -sf /dev/stderr /var/log/apache2/error.log

WORKDIR /usr/share/shared-folder

COPY . /usr/share/shared-folder/

RUN npm install && npm cache clean --force && npm cache verify && \
 rm /var/www/html/index.html && \
 ln -s /usr/share/shared-folder/mochawesome-report /var/www/html/mochawesome-report && \
 chown www-data -R /var/www/html/mochawesome-report && chgrp www-data -R /var/www/html/mochawesome-report

VOLUME /usr/share/shared-folder/mochawesome-report

COPY sugarcrm-13.0.x /var/www/html/sugarcrm

RUN chown www-data:www-data -R /var/www/html/sugarcrm && \
 chmod 775 -R /var/www/html/sugarcrm && \
 chmod 664 -R /var/www/html/sugarcrm/config.php && \
 chmod 664 -R /var/www/html/sugarcrm/config_override.php && \
 chmod 664 -R /var/www/html/sugarcrm/sugarcrm.log

COPY /etc/apache2 /etc/apache2

RUN nano /etc/apache2/sites-available/default-ssl.conf

ServerName www.example.com
SSLCertificateFile /etc/apache2/ssl/example.crt
SSLCertificateKeyFile /etc/apache2/ssl/example.key

COPY example.crt /etc/apache2/ssl/example.crt
COPY example.key /etc/apache2/ssl/example.key

RUN a2enmod proxy proxy_http proxy_balancer lbmethod_byrequests ssl

RUN nano /etc/apache2/sites-available/000-default.conf

ProxyPass / http://localhost:8080/
ProxyPassReverse / http://localhost:8080/


USER 1001

CMD [ "sh", "-c", "service apache2 start ; --no-daemon" ]
