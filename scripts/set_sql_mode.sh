#!/bin/bash

get_mysql_version() {
  mysql_version=$(mysql -V | cut -d ' ' -f 6 | cut -d '.' -f 1)
  echo $mysql_version
}

set_sql_mode() {
  mysql_version=$(get_mysql_version)
  if [[ $mysql_version -ge 8 ]]; then
    sql_mode="STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION"
  else
    sql_mode="STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"
  fi
  mysql -e "SET GLOBAL sql_mode='$sql_mode';"
}

set_sql_mode
