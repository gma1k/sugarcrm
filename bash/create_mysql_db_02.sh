#!/bin/sh

create_mysql_db() {
  if ! command -v mysql &> /dev/null
  then
    echo "mysql command not found. Please install mysql client or server."
    exit 1
  fi

  read -s -p "Enter mysql root password: " MYSQL_ROOT_PASSWORD
  echo

  mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE $DBNAME CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;"

  if [ $? -eq 0 ]; then
    echo "Database $DBNAME created successfully."
  else
    echo "Database $DBNAME creation failed."
    exit 1
  fi

  read -p "Enter sugarcrm user name: " SUGARCRM_USER
  read -s -p "Enter sugarcrm user password: " SUGARCRM_PASSWORD
  echo
  mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE USER '$SUGARCRM_USER'@'localhost' IDENTIFIED BY '$SUGARCRM_PASSWORD';"
  mysql -u root -p$MYSQL_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON $DBNAME.* TO '$SUGARCRM_USER'@'localhost';"
  mysql -u root -p$MYSQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"

  if [ $? -eq 0 ]; then
    echo "User $SUGARCRM_USER created and granted successfully."
  else
    echo "User $SUGARCRM_USER creation and grant failed."
    exit 1
  fi

}

configure_sugarcrm() {
  if [ ! -d "/var/www/html/sugarcrm" ]; then
    echo "Sugarcrm directory not found. Please install sugarcrm first."
    exit 1
  fi

  cp /var/www/html/sugarcrm/config_si.php .

  if [ $? -eq 0 ]; then
    echo "Config_si.php file copied successfully."
  else
    echo "Config_si.php file copy failed."
    exit 1
  fi

  sed -i "s/'db_name' => 'sugarcrm',/'db_name' => '$DBNAME',/" config_si.php
  sed -i "s/'db_user_name' => 'root',/'db_user_name' => '$SUGARCRM_USER',/" config_si.php
  sed -i "s/'db_password' => '',/'db_password' => '$SUGARCRM_PASSWORD',/" config_si.php

}

read -p "Enter the database name: " DBNAME
create_mysql_db

configure_sugarcrm
