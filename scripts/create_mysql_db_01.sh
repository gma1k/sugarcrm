#!/bin/bash

create_mysql_db() {
  read -p "Enter the database name: " DBNAME
  if [[ -z "$DBNAME" ]]; then
    echo "Invalid database name"
    exit 1
  fi
  if mysql -e "SHOW DATABASES LIKE '$DBNAME'" | grep -q "$DBNAME"; then
    echo "Database $DBNAME already exists"
    exit 1
  fi
  mysql -e "DROP DATABASE IF EXISTS $DBNAME;
  CREATE DATABASE $DBNAME CHARACTER SET utf8 COLLATE utf8_unicode_ci;
  USE $DBNAME;
  SET GLOBAL innodb_log_file_size = 2048 * 1024 * 1024;"
  if [[ $? -eq 0 ]]; then
    echo "Database $DBNAME created and configured successfully"
    exit 0
  else
    echo "Database creation and configuration failed"
    exit 1
  fi
}

create_mysql_db
