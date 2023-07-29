#!/bin/bash

create_tls_secret() {
  read -p "Enter the secret name: " secret_name
  read -p "Enter the domain name: " domain_name
  read -p "Enter the certificate file: " cert_file
  read -p "Enter the key file: " key_file

  if [[ -f "$cert_file" && -r "$cert_file" && -f "$key_file" && -r "$key_file" ]]; then
    kubectl create secret tls "$secret_name" --cert="$cert_file" --key="$key_file"
    if [[ $? -eq 0 ]]; then
      echo "Secret $secret_name created for domain $domain_name"
    else
      echo "Failed to create secret $secret_name"
    fi
  else
    echo "Invalid certificate or key file"
  fi
}

create_mysql_secret() {
  read -p "Enter the secret name: " secret_name
  read -p "Enter the host name: " host_name
  read -p "Enter the user name: " user_name
  read -p "Enter the password: " password
  read -p "Enter the database name: " database_name

  host_encoded=$(echo -n "$host_name" | base64)
  user_encoded=$(echo -n "$user_name" | base64)
  password_encoded=$(echo -n "$password" | base64)
  database_encoded=$(echo -n "$database_name" | base64)

  tmp_file=$(mktemp)
  cat > "$tmp_file" <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: $secret_name
type: Opaque
data:
  host: $host_encoded
  user: $user_encoded
  password: $password_encoded
  database: $database_encoded 
EOF

  kubectl apply -f "$tmp_file"
  if [[ $? -eq 0 ]]; then
    echo "Secret $secret_name created for MySQL"
  else
    echo "Failed to create secret $secret_name"
  fi

  rm "$tmp_file"
}

show_usage() {
  echo "Usage: $0 tls|mysql"
  exit 1
}

if [[ $# -eq 1 ]]; then
  case "$1" in 
    tls)
      create_tls_secret ;;
    mysql)
      create_mysql_secret ;;
    *)
      show_usage ;;
   esac 
else 
   show_usage 
fi
