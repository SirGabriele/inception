FROM debian:bullseye-slim 

#Directory
WORKDIR /app

#Install requirements and create non-root user
RUN apt-get update &&\
	apt-get install nginx -y &&\
	apt-get clean

#ENTRYPOINT ["nginx", "-g", "daemon off;"]
