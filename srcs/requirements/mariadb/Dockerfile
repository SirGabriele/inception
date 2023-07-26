FROM debian:bullseye-slim 

#Directory
WORKDIR /app

#Install requirements
RUN apt-get update &&\
	apt-get install mariadb-server -y &&\
	apt-get install mariadb-client -y

COPY ./tools/installment.sh /usr/bin/

#Expose
EXPOSE 3306/tcp

#ENTRYPOINT ["/usr/bin/installment.sh"]
CMD ["sleep", "infinity"]
