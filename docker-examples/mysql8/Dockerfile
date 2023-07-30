FROM mysql:8.0
ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_DATABASE=sugarcrm
ENV MYSQL_USER=sugarcrm
ENV MYSQL_PASSWORD=sugarcrm
COPY sugarcrm.sql /docker-entrypoint-initdb.d/
ENV HTTP_PROXY=http://proxy.example.com:8080
ENV HTTPS_PROXY=http://proxy.example.com:8080
EXPOSE 3306
