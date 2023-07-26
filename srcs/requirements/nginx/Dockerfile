FROM debian:bullseye-slim 

#Directory
WORKDIR /app

#Install requirements and create non-root user
RUN apt-get update &&\
	apt-get install nginx -y &&\
	apt-get install openssl &&\
	mkdir /etc/nginx/ssl &&\
	mkdir /etc/nginx/logs &&\
	openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/kbrousse.42.fr.key -out /etc/nginx/ssl/kbrousse.42.fr.crt -subj "/C=FR/ST=Charente/L=Angouleme/O=42/OU=42/CN=kbrousse.42.fr" &&\
	apt-get clean

COPY conf/nginx.conf /etc/nginx/

#Expose
EXPOSE 443/tcp

ENTRYPOINT ["nginx", "-g", "daemon off;"]
