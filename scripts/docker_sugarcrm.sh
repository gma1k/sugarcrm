#!/bin/bash

pull_images() {
  echo "Pulling the SugarCRM image..."
  docker pull sugarcrm/sugarcrm:12.0.0
  if [[ $? -eq 0 ]]; then
    echo "SugarCRM image pulled successfully"
  else
    echo "Failed to pull SugarCRM image"
    exit 1
  fi

  echo "Pulling the MySQL image..."
  docker pull mysql:5.7
  if [[ $? -eq 0 ]]; then
    echo "MySQL image pulled successfully"
  else
    echo "Failed to pull MySQL image"
    exit 1
  fi
}

create_network() {
  read -p "Enter the network name: " network_name

  echo "Creating the network $network_name..."
  docker network create "$network_name"
  if [[ $? -eq 0 ]]; then
    echo "Network $network_name created successfully"
  else
    echo "Failed to create network $network_name"
    exit 1
  fi
}

create_volume() {
  read -p "Enter the volume name: " volume_name

  echo "Creating the volume $volume_name..."
  docker volume create "$volume_name"
  if [[ $? -eq 0 ]]; then
    echo "Volume $volume_name created successfully"
  else
    echo "Failed to create volume $volume_name"
    exit 1
  fi
}

run_mysql() {
  read -p "Enter the MySQL container name: " mysql_name
  read -p "Enter the MySQL root password: " mysql_root_password
  read -p "Enter the MySQL database name: " mysql_database_name
  read -p "Enter the MySQL user name: " mysql_user_name
  read -p "Enter the MySQL user password: " mysql_user_password

  echo "Running the MySQL container $mysql_name..."
  docker run --name "$mysql_name" \
    -e MYSQL_ROOT_PASSWORD="$mysql_root_password" \
    -e MYSQL_DATABASE="$mysql_database_name" \
    -e MYSQL_USER="$mysql_user_name" \
    -e MYSQL_PASSWORD="$mysql_user_password" \
    -v "$volume_name:/var/lib/mysql" \
    --network "$network_name" \
    -d mysql:5.7

   if [[ $? -eq 0 ]]; then 
     echo "MySQL container $mysql_name run successfully" 
   else 
     echo "Failed to run MySQL container $mysql_name" 
     exit 
   fi 
}

run_sugarcrm() { 
   read -p "Enter the SugarCRM container name: " sugarcrm_name 
   read -p "Enter the host port to map to port 80 of SugarCRM: " host_port 

   echo "Running the SugarCRM container $sugarcrm_name..." 
   docker run --name "$sugarcrm_name" \
     -p "$host_port:80" \
     -e DB_HOST="$mysql_name" \
     -e DB_USER="$mysql_user_name" \
     -e DB_PASSWORD="$mysql_user_password" \
     -e DB_NAME="$mysql_database_name" \
     -e DB_TYPE=mysql \
     -e DB_TCP_PORT=3306 \
     -e DB_MANAGER=MysqlManager \
     --network "$network_name" \
     -d sugarcrm/sugarcrm:12.0.0 

   if [[ $? -eq 0 ]]; then 
     echo "SugarCRM container $sugarcrm_name run successfully" 
   else 
     echo "Failed to run SugarCRM container $sugarcrm_name" 
     exit 1 
   fi 
}

pull_images
create_network
create_volume
run_mysql
run_sugarcrm

echo "You can access SugarCRM at http://localhost:$host_port/"
