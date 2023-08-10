#! /bin/bash

function info
{
	echo -e "\e[0;92m[info] $1\e[0m"
}

#Download the latest version of wordpress and set it up
if [ -d /var/www/wordpress ] && [ "$(ls -A /var/www/wordpress)" ];
then
	info "Wordpress is already installed"
else
	info "Installing wordpress ..."
	wget https://wordpress.org/latest.tar.gz -P /var/www
	tar xf /var/www/latest.tar.gz -C /var/www
	rm /var/www/latest.tar.gz
	mv /var/www/wordpress/wp-config-sample.php /var/www/wordpress/wp-config.php
	chown -R www-data:www-data /var/www/wordpress
	chmod -R 755 /var/www/wordpress
	sed -i -e "s/database_name_here/${DB_NAME}/g" \
		-e "s/username_here/${DB_USERNAME}/g" \
		-e "s/password_here/${DB_PASSWD}/g" \
		-e "s/localhost/${DB_HOSTNAME}/g" /var/www/wordpress/wp-config.php
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

#Download wp-cli
if [ -f /usr/bin/wp-cli.phar ];
then
	info "wp-cli.phar is already installed"
else
	info "Installing wp-cli.phar ..."
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/bin/
fi

#Launch php-fpm7.4
if [[ $(/usr/sbin/php-fpm7.4 -F -R 2>/dev/null) ]];
then
	:
else
	info "/usr/sbin/php-fpm7.4 is already running"
fi
