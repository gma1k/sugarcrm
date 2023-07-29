#!/bin/bash

export DOCKER_USERNAME=your-username
export DOCKER_PASSWORD=your-password
export CF_USERNAME=your-username
export CF_PASSWORD=your-password
export DB_HOST=your-host
export DB_PORT=your-port
export DB_NAME=your-name
export DB_USER=your-user
export DB_PASSWORD=your-password

fly -t your-target execute -c pipeline.yml

unset DOCKER_USERNAME
unset DOCKER_PASSWORD
unset CF_USERNAME
unset CF_PASSWORD
unset DB_HOST
unset DB_PORT
unset DB_NAME
unset DB_USER
unset DB_PASSWORD
