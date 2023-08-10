#! /bin/bash

function info
{
	echo -e "\e[0;92m[info] $1\e[0m"
}

#Starts mariadb service
info "Starting mariadb ..."
service mariadb start

#Executes the securing script
info "Securing databases ..."
mysql_secure_installation << EOF

y
y
$DB_ROOT_PASSWD
$DB_ROOT_PASSWD
y
y
y
y
EOF

mariadb -e "create user if not exists $DB_ADMIN_NAME@localhost identified by '$DB_ADMIN_PASSWD'"
mariadb -e "create database if not exists $DB_NAME"
mariadb -e "grant all privileges on $DB_NAME.* to $DB_ADMIN_NAME@localhost"
mariadb -e "flush privileges"
#mariadb -u$DB_ADMIN_NAME -p$DB_ADMIN_PASSWD $DB_NAME

sleep 2
info "Stopping mariadb ..."
service mariadb stop

info "Listening ..."
mariadbd --bind-address=0.0.0.0
