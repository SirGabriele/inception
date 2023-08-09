#! /bin/bash

function info
{
	echo -e "\e[0;92m[info] $1\e[0m"
}

#Download the latest version of wordpress
wget https://fr.wordpress.org/latest-fr_FR.tar.gz -P /var/www
tar xfv /var/www/latest-fr_FR.tar.gz -C /var/www
rm /var/www/latest-fr_FR.tar.gz
