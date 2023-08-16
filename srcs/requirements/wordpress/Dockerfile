FROM debian:bullseye-slim 

#Directory
WORKDIR /app

#Install requirements
RUN apt-get update &&\
	apt-get install wget -y &&\
	apt-get install php -y &&\
	apt-get install php-mysql -y &&\
	apt-get install php7.4-fpm -y &&\
	apt-get install mariadb-client -y &&\
	apt-get clean

COPY ./scripts/installment.sh /usr/bin/

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY ./communism.html /var/www/wordpress/

ENTRYPOINT ["/usr/bin/installment.sh"]
