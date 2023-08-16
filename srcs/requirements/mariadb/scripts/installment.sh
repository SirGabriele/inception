#! /bin/bash

function info
{
	echo -e "\e[0;92m[info] $1\e[0m"
}

#Starts mariadb service
info "Starting mariadb ..."
service mariadb start
info "apres le service"
sleep 10

mariadb -e "create user if not exists '$DB_ADMIN_NAME'@'localhost' identified by '$DB_ADMIN_PASSWD'"
mariadb -e "create database if not exists $DB_NAME"
mariadb -e "grant all privileges on $DB_NAME.* to '$DB_ADMIN_NAME'@'localhost'"
mariadb -e "flush privileges"

sleep 3

info "Stopping mariadb ..."
service mariadb stop

mariadb -u$DB_ADMIN_NAME -p$DB_ADMIN_PASSWD $DB_NAME

sleep 3

info "Listening ..."
mariadbd --bind-address=0.0.0.0
