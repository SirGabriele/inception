#! /bin/bash

function info
{
	echo -e "\e[0;92m[info] $1\e[0m"
}

info "Starting mariadb ..."
service mariadb start

info "Securing databases ..."
mysql_secure_installation << EOF

y
y
password
password
y
y
y
y
EOF
