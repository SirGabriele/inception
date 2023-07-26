FROM debian:bullseye-slim 

ARG CREATED_USER=kbrousse

#Directory
WORKDIR /app

#Install requirements and create non-root user
RUN apt-get update &&\
	apt-get install nginx -y &&\
	apt-get install openssl &&\
	mkdir /etc/nginx/ssl &&\
	useradd ${CREATED_USER} &&\
	openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/kbrousse.42.fr.key -out /etc/nginx/ssl/kbrousse.42.fr.crt -subj "/C=FR/ST=Charente/L=Angouleme/O=42/OU=42/CN=kbrousse.42.fr" &&\
	apt-get clean

COPY conf/nginx.conf /etc/nginx/

#Switching to non-root user
#USER ${CREATED_USER}:${CREATED_USER}

#Expose
EXPOSE 443/tcp

ENTRYPOINT ["nginx", "-g", "daemon off;"]
