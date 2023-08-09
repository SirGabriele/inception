#! /bin/bash

function info
{
	echo -e "\e[0;92m[info] $1\e[0m"
}

#Download the latest version of wordpress
if [ -d /var/www/wordpress ] && [ "$(ls -A /var/www/wordpress)" ];
then
	info "Wordpress is already installed"
else
	wget https://fr.wordpress.org/latest-fr_FR.tar.gz -P /var/www
	tar xfv /var/www/latest-fr_FR.tar.gz -C /var/www
	rm /var/www/latest-fr_FR.tar.gz
fi

#Start the php-fpm service
if [ -d /run/php ];
then
	info "Php-fpm service is already running."
else
	info "Starting php-fpm service ..."
	service php7.4-fpm start
fi
