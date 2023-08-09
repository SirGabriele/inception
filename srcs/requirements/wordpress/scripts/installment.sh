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
	tar xf /var/www/latest-fr_FR.tar.gz -C /var/www
	rm /var/www/latest-fr_FR.tar.gz
	chown -R www-data:www-data /var/www/wordpress
	chmod -R 755 /var/www/wordpress
	sleep 3
fi

#Start the php-fpm service
if [ -d /run/php ];
then
	info "Php-fpm service is already running."
else
	info "Creating /run/php"
	mkdir /run/php
	sleep 3
fi

#Launch php7.4
/usr/sbin/php-fpm7.4 -F -R
