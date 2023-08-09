FROM debian:bullseye-slim 

#Directory
WORKDIR /app

#Install requirements
RUN apt-get update &&\
	apt-get install wget -y &&\
	apt-get clean

COPY ./scripts/installment.sh /usr/bin/

#Expose
EXPOSE 9000/tcp

#ENTRYPOINT ["/usr/bin/installment.sh"]

CMD ["sleep", "infinity"]
