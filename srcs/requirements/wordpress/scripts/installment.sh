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
	info "Installing wordpress ..."
	wget https://fr.wordpress.org/latest-fr_FR.tar.gz -P /var/www
	tar xf /var/www/latest-fr_FR.tar.gz -C /var/www
	rm /var/www/latest-fr_FR.tar.gz
	mv /var/www/wordpress/wp-config-sample.php /var/www/wordpress/wp-config.php
	chown -R www-data:www-data /var/www/wordpress
	chmod -R 755 /var/www/wordpress
	sed -i -e "s/votre_nom_de_bdd/${DB_NAME}/g" \
		-e "s/votre_utilisateur_de_bdd/${DB_NAME}/g" \
		-e "s/votre_mdp_de_bdd/${DB_PASSWD}/g" \
		-e "s/localhost/${DB_HOST}/g" /var/www/wordpress/wp-config.php
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
if [ -d wp-cli.phar ];
then
	info "wp-cli.phar is already installed"
else
	info "Installing wp-cli.phar ..."
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/bin/
fi

#Launch php7.4
#if [[ $(ps -aux | grep php) ]];
#then
#	info "/usr/sbin/php-fpm7.4 is already running"
#else
	/usr/sbin/php-fpm7.4 -F -R
#fi
