FROM mysql:5.7
RUN groupadd -r mysql && useradd --no-log-init -r -g mysql mysql
USER mysql
COPY my.cnf /etc/mysql/conf.d/
EXPOSE 3306
