FROM node:14.7.0-buster-slim AS apache_for_sugarcrm
RUN addgroup --system shared-folder \
 && adduser --system --home /var/cache/shared-folder --group shared-folder --uid 1001
EXPOSE 80/tcp
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
USER 1001
CMD [ "sh", "-c", "service apache2 start ; pm2-runtime process.yml --no-daemon" ]
