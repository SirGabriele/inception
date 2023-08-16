#! /bin/bash

function info
{
	echo -e "\e[0;92m[info] $1\e[0m"
}

#Download wp-cli
if [ -f /usr/bin/wp ];
then
	info "wp-cli.phar is already installed"
else
	info "Installing wp-cli.phar ..."
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/bin/wp
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

#Download the latest version of wordpress and set it up
if [ -d /var/www/wordpress/index.php ] && [ "$(ls /var/www/wordpress)" ];
then
	info "Wordpress is already installed"
else
	sleep 3
	info "Installing wordpress ..."
	chown -R www-data:www-data /var/www/wordpress
	chmod -R 755 /var/www/wordpress
	cd /var/www/wordpress
		info "wp core download"
	wp core download --allow-root
		info "wp config create"
	sleep 3
		info "sedding"
	sed -i -e "s/database_name_here/${DB_NAME}/g" \
		-e "s/username_here/${DB_ADMIN_NAME}/g" \
		-e "s/password_here/${DB_ADMIN_PASSWD}/g" \
		-e "s/localhost/${DB_HOSTNAME}/g" wp-config-sample.php
		info "mv"
	mv wp-config-sample.php wp-config.php
	sleep 3
		info "wp core install"
	wp core install --path=/var/www/wordpress --allow-root --url=kbrousse.42.fr --title="My title" --admin_user=$DB_ADMIN_NAME --admin_password=$DB_ADMIN_PASSWD --admin_email=$DB_ADMIN_EMAIL --skip-email
		info "wp user create"
	wp user create $DB_USER_NAME $DB_USER_EMAIL --path=/var/www/wordpress --role=subscriber --user_pass=$DB_USER_PASSWD --allow-root
fi

#Launch php-fpm7.4
if [[ $(/usr/sbin/php-fpm7.4 -F -R 2>/dev/null) ]];
then
	:
else
	info "/usr/sbin/php-fpm7.4 is already running"
fi
