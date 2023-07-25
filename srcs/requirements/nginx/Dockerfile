FROM debian:bullseye-slim 

ARG CREATED_USER=kbrousse

#Directory
WORKDIR /app

#Install requirements and create non-root user
RUN apt-get update &&\
	apt-get install nginx -y &&\
	apt-get install openssl -y &&\
	mkdir /etc/nginx/ssl &&\
	useradd ${CREATED_USER} &&\
	apt-get clean

COPY conf/nginx.conf /etc/nginx/
COPY certificate.crt /etc/nginx/ssl/
COPY rsakey.key /etc/nginx/ssl/

#Switching to non-root user
#USER ${CREATED_USER}:${CREATED_USER}

#Expose
EXPOSE 80/tcp

ENTRYPOINT ["nginx", "-g", "daemon off;"]
