FROM php:7.4-cli
RUN groupadd -r sugarcrm && useradd --no-log-init -r -g sugarcrm sugarcrm
USER sugarcrm
COPY --chown=sugarcrm:sugarcrm . /opt/sugarcrm
RUN chmod -R 755 /opt/sugarcrm
ENV DB_HOST=mysql \
    DB_USER=sugarcrm \
    DB_PASSWORD=sugarcrm \
    DB_NAME=sugarcrm \
    DB_TYPE=mysql \
    DB_TCP_PORT=3306 \
    DB_MANAGER=MysqlManager
EXPOSE 80
WORKDIR /opt/sugarcrm
CMD ["php", "-S", "0.0.0.0:80"]
